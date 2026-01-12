# POS Application Documentation

## Introduction

This document provides documentation for a simple command-line POS (Point of Sale) application written in Python.

## Features

*   **Product Catalog:** A hardcoded dictionary of products with their names and prices.
*   **Shopping Cart:** Users can add multiple products to a shopping cart.
*   **Total Calculation:** The application calculates the total price of all items in the cart.
*   **Receipt Generation:** A simple receipt is printed to the console upon checkout.

## Documentation

*   [Master Product Documentation](MASTER_PRODUCT.md)

## Installation

To run this application, you need Python 3 installed on your system. No external libraries are required.

1.  Clone this repository or download the `main.py` file.
2.  Open a terminal or command prompt.
3.  Navigate to the directory where `main.py` is located.

## Usage

To run the application, execute the following command in your terminal:

```bash
python main.py
```

You will be presented with a menu of options:

1.  **Add item to cart:** Prompts you to enter a product ID and quantity to add to your cart.
2.  **View cart:** Displays the current items in your cart.
3.  **Checkout:** Calculates the total price and prints a receipt. The application will then exit.
4.  **Exit:** Exits the application without checking out.

## Contributing

This is a simple application for demonstration purposes. If you would like to contribute, you can fork the repository and submit a pull request with your changes.
