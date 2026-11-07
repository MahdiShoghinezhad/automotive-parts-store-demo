# Proposed Production Architecture / معماری پیشنهادی نسخه عملیاتی

**Author / تهیه‌کننده: Mahdi Shoghinezhad (مهدی شوقی‌نژاد)**

## Status

This document is a **proposal** for future implementation, **not evidence that a working Laravel backend currently exists**.

این سند یک **طرح فنی پیشنهادی** است و به معنی پیاده‌سازی بک‌اند Laravel در دموی فعلی نیست.

## Stack choice

- **Production application:** Laravel (PHP) + MySQL + a dedicated storefront UI.
- **Admin:** Filament, extended for catalog, stock, orders, and fitment administration.
- **API:** Versioned REST for vehicle lookup, product search, cart/order services, with RBAC.
- **Background work:** Laravel queues for imports, notifications and asynchronous catalog updates.
- **Optional Python:** a separate Python microservice if advanced matching, AI recommendations or data normalization becomes necessary. Avoid premature microservices for a 14-day MVP.

Django/Python is a viable alternative for an all-new backend but is not inherently superior for a conventional commerce MVP. The project's previously discussed Laravel stack should not change without explicit agreement on scope, timing, and budget.

## Fitment data model

Store manufacturers, models, vehicle variants, products, product variants, and explicit part-to-vehicle compatibility records. Do **not** infer compatibility from text or vehicle names. Import only verified supplier data and record source, update time and approvals. See [example SQL](fitment-schema.sql).

Main relationships:

- `vehicle_makes` 1 → N `vehicle_models`
- `vehicle_models` 1 → N `vehicle_variants` (year, trim, engine)
- `products` N ↔ N `vehicle_variants` through `product_fitments`
- `products` 1 → N `inventory_items` (if multiple warehouses)
- `orders` 1 → N `order_items` (price/sku snapshot at sale)

## Search design

Index normalized SKU, make/model identifiers, fitment junction keys, inventory status, and category. The storefront should query by **vehicle variant id** rather than free-text substring matching. Validate compatibility server-side before checkout; display fitment notes and exceptions.

## Quality and security gates

- Authentication and authorization for administrative operations.
- Validation and strict transaction rules for price/stock/order updates.
- Reserved inventory, payment callback verification, idempotency keys, anti-oversell safeguards.
- CSRF protection, rate limiting, secure session cookies, auditing, logging and backups.
- Accessibility, SEO metadata, structured product data and performance budgets.
- Unit, feature, integration and end-to-end tests across critical flows.

## Delivery approach

1. Confirm fields, product/vehicle catalogs, payment provider, shipping integration, and acceptance criteria.
2. Finalize designs and data schema; implement verified fitment catalog, product browse, search and admin.
3. Implement sessions/cart, orders, payment integration and inventory logic.
4. Test security, correctness, speed and deployment with representative real data.

**Delivery estimates depend on agreed acceptance criteria and supplied data.** The 14-day period previously proposed for an MVP requires a tightly scoped release and prompt access to assets and approvals.