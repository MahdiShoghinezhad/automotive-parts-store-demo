"""Smoke tests for the self-contained PartSync HTML portfolio demo."""
from pathlib import Path
from playwright.sync_api import sync_playwright

ROOT = Path(__file__).resolve().parents[1]


def test_partsync():
    with sync_playwright() as p:
        chromium_path = Path('/usr/bin/chromium')
        options = {'executable_path': str(chromium_path)} if chromium_path.exists() else {}
        browser = p.chromium.launch(headless=True, **options)
        page = browser.new_page(viewport={"width": 1280, "height": 900})
        errors = []
        page.on("pageerror", lambda err: errors.append(str(err)))
        page.set_content((ROOT / "index.html").read_text(encoding="utf-8"))

        assert page.locator("html").get_attribute("lang") == "fa"
        assert page.locator(".product-card").count() == 12

        page.locator("#vehicle-make").select_option("پژو")
        page.locator("#vehicle-model").select_option("۲۰۶")
        page.locator("#vehicle-year").select_option("1398")
        page.locator("#vehicle-trim").select_option("تیپ ۲")
        page.locator("#apply-fitment").click()
        assert page.locator(".product-card").count() == 2

        page.locator("#clear-filters").click()
        page.locator("#catalog-search").fill("BR-102")
        assert page.locator(".product-card").count() == 1
        page.locator("#catalog-search").fill("")
        page.locator("#lang-toggle").click()
        assert page.locator("html").get_attribute("lang") == "en"
        assert page.locator("html").get_attribute("dir") == "ltr"
        assert not errors, errors
        browser.close()