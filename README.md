# PartSync — Bilingual Automotive Parts Store Demo

**Persian / English · RTL / LTR · Vehicle fitment · Responsive e-commerce UI**

Designed and developed by **Mahdi Shoghinezhad** — Full-Stack Software Engineer.

## English — My project

I built **PartSync** as an independent, interactive front-end portfolio project to demonstrate how I would approach the user experience of an automotive spare-parts store. The interface lets users select a vehicle by make, model, year and trim, then browse sample compatible parts.

My implementation includes bilingual Persian/English language switching, RTL/LTR layouts, SKU and brand search, category filtering, price sorting, and a demonstration cart with quantity controls.

**Technical references:** [Architecture](docs/architecture.md) · [Illustrative SQL schema](docs/fitment-schema.sql) · [Browser smoke test](tests/smoke_test.py).\n\n**Browser tests:** Install `pip install pytest playwright` and `playwright install chromium`, then run `pytest -q`.\n\n**Live demo:** Enable GitHub Pages from `main` → `/(root)`; this self-contained `index.html` runs without dependencies.

**Important:** This is an independently built **front-end demonstration**, not a commissioned, completed production store. All product data, fitment mappings and prices are fictional. This repository does not implement a backend, persistent database, real inventory, checkout, payments, or administration.

**Planned production architecture:** For a contracted store, my proposed stack is Laravel + MySQL with a custom product/vehicle compatibility model, role-controlled administration, tested ordering and gateway integration. Python/Django is also a viable alternative when project scope and requirements favor it.

## فارسی — معرفی پروژه من

من **PartSync** را به‌عنوان **نمونه‌کار شخصی و مستقل** برای نمایش طراحی و پیاده‌سازی رابط فروشگاه تخصصی قطعات خودرو توسعه داده‌ام. در این نمونه، کاربر ابتدا برند، مدل، سال و تیپ خودرو را انتخاب می‌کند و سپس قطعات آزمایشی مرتبط با خودرو را مشاهده می‌کند.

امکانات نمونه شامل تغییر واقعی زبان فارسی و انگلیسی، چیدمان راست‌چین و چپ‌چین، جستجوی کد فنی، دسته‌بندی محصولات، مرتب‌سازی قیمت و سبد خرید نمایشی است.

برای مشاهده جزئیات فنی، [معماری پیشنهادی](docs/architecture.md)، [طرح SQL](docs/fitment-schema.sql) و [تست مرورگر](tests/smoke_test.py) را مطالعه کنید.\n\nبرای اجرای این نمونه کافی است `index.html` را در مرورگر باز کنید. برای انتشار آنلاین می‌توان از GitHub Pages استفاده کرد.

**توضیح مهم:** این پروژه یک **نمونه تعاملی فرانت‌اند** است، نه فروشگاه عملیاتی تحویل‌شده به مشتری. نام محصولات، قیمت‌ها و اطلاعات سازگاری خودروها آزمایشی‌اند. در نسخه فعلی بک‌اند، دیتابیس متصل، سفارش واقعی، پرداخت یا پنل مدیریت وجود ندارد.

**توسعه‌دهنده:** مهدی شوقی‌نژاد

© 2026 Mahdi Shoghinezhad