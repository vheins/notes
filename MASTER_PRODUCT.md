# Master Product Documentation

This document describes the structure and management of master products in the POS application.

## Product Attributes

A master product has the following attributes:

*   **id:** A unique identifier for the product.
*   **name:** The name of the product.
*   **price:** The price of the product.
*   **stock:** The quantity of the product in stock.

## Product Management Flowchart

```mermaid
graph TD
    A[Start] --> B{Manage Products};
    B --> C[Add New Product];
    B --> D[Update Existing Product];
    B --> E[Delete Product];
    C --> F[Enter Product Details];
    F --> G[Save Product];
    G --> H[End];
    D --> I[Select Product to Update];
    I --> J[Enter Updated Details];
    J --> K[Save Changes];
    K --> H;
    E --> L[Select Product to Delete];
    L --> M[Confirm Deletion];
    M --> N[Delete Product from Database];
    N --> H;
```

## Database Entity Relationship Diagram (ERD)

```mermaid
erDiagram
    PRODUCT {
        int id PK
        varchar name
        decimal price
        int stock
    }
```
