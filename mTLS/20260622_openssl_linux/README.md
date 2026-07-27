# mTLS Certificate Delivery Deployment Map (m.dsd.gov.hk)

Generated on: 2026-06-22 14:57:42

This directory contains the mutual authentication infrastructure assets required to complete mTLS operations.

## File Registry & System Assignments

### 1. Root Certificate Authority (CA)
*   **root.m.dsd.gov.hk.20260622.crt / .pem**
    *   *Purpose:* The dedicated anchor identity of your custom Root CA.
    *   *Deployment:* Must be imported into the IIS Server context. Install this inside the Local Computer container located under the `Trusted Root Certification Authorities` node.
*   **root.m.dsd.gov.hk.20260622.key**
    *   *Purpose:* Private key governing the root authorization container.
    *   *Deployment:* **Keep highly secure.** Do not export or host publicly.

### 2. Intermediate Certificate Authority (CA)
*   **int.m.dsd.gov.hk.20260622.crt / .pem**
    * *Purpose:* The Intermediate signing identity acting as the operational CA issuing client and server blocks.
    * *Deployment:* Import into the web host's `Intermediate Certification Authorities` store to allow server endpoints to properly track issues downwards.
*   **int.m.dsd.gov.hk.20260622.key / .csr**
    * *Purpose:* Cryptographic signing key and signing request metadata for the operational layer.
*   **chain.m.dsd.gov.hk.20260622.pem**
    * *Purpose:* A bundled, linear concatenation of the Intermediate CA certificate followed by the Root CA certificate.
    * *Deployment:* Essential for Linux Nginx ecosystems. Provided directly via the `ssl_client_certificate` parameter to evaluate the whole certificate authority pipeline.

### 3. Client Identity Assets
*   **client.m.dsd.gov.hk.20260622.pfx**
    * *Purpose:* The identity profile containing the client's public certificate chain alongside its corresponding cryptographic private signature key.
    * *Deployment:* Install directly on client hosts or target API runtimes. Typically imported into browser personnel nodes or mobile app bundles.
*   **client.m.dsd.gov.hk.passphrase.20260622.txt**
    * *Purpose:* The system-generated operational extraction string needed to unlock the secure `.pfx` client package payload.
*   **client.m.dsd.gov.hk.20260622.csr / .pem / .key**
    * *Purpose:* Raw diagnostic working tokens tracking signing metadata requests, signed PEM elements, and isolated algorithmic client private access keys.

### 4. Isolated Server Components
*   **server.m.dsd.gov.hk.20260622.base64.cer.txt**
    * *Purpose:* A clean, isolated Base64 string version of the server's public key (omitting standard header strings).
    * *Deployment:* Configured directly inside the IIS Client Certificate Mapping Authentication array tables to bind explicit permissions to incoming transactions.
*   **server.m.dsd.gov.hk.20260622.crt / .pem / .key / .csr**
    * *Purpose:* Standard cryptographic assets tracking host keys and validation blocks.
    * *Deployment:* These serve as local validation backups. The web app's live external bindings remain safe under your public web server profile.
