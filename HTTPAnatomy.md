# HTTP İsteğinin Anatomisi

Adil Arkalı - HW2  

---

## HTTP Nedir?

**HTTP (HyperText Transfer Protocol)**, bir istemci (client) ile sunucu (server) arasındaki veri alışverişini düzenleyen metin tabanlı bir protokoldür.

- **Stateless (Durumsuz):** Her istek birbirinden bağımsızdır, sunucu önceki isteği hatırlamaz.
- **Port:** Varsayılan olarak `80` (HTTP) ve `443` (HTTPS) portları kullanılır.

```
İstemci (Tarayıcı)  ──── HTTP İsteği ────→  Sunucu
                    ←─── HTTP Yanıtı ────
```

---

## HTTP İsteğinin Yapısı

Bir HTTP isteği **3 ana bölümden** oluşur:

```
┌──────────────────────────────┐
│         REQUEST LINE         │  ← Metot + URL + HTTP Versiyonu
├──────────────────────────────┤
│           HEADERS            │  ← Meta veriler (anahtar: değer)
├──────────────────────────────┤
│        BODY (opsiyonel)      │  ← Gönderilen asıl veri
└──────────────────────────────┘
```

---

## 1. Request Line (İstek Satırı)

İsteğin **ne yapılacağını**, **nereye** yapılacağını ve **hangi HTTP versiyonunun** kullanıldığını belirtir.

```
POST /api/kullanicilar HTTP/1.1
 │          │              │
 │          │              └── HTTP Versiyonu
 │          └───────────────── Kaynak Yolu (Path)
 └──────────────────────────── HTTP Metodu
```

### HTTP Metotları

| Metot | Amaç |
|-------|------|
| `GET` | Veri okuma |
| `POST` | Yeni kayıt oluşturma |
| `PUT` | Kaydı tamamen güncelleme |
| `PATCH` | Kaydı kısmen güncelleme |
| `DELETE` | Kayıt silme |

---

## 2. Headers (Başlıklar)

İstek hakkında **meta bilgi** taşır. `Anahtar: Değer` formatındadır.

```http
Host: www.example.com
Content-Type: application/json
Authorization: Bearer eyJhbGci...
Accept: application/json
```

| Header | Açıklama |
|--------|----------|
| `Host` | İsteğin gönderildiği sunucu adresi |
| `Content-Type` | Body'deki verinin formatı |
| `Authorization` | Kimlik doğrulama token'ı |
| `Accept` | İstemcinin kabul ettiği yanıt formatı |
| `Content-Length` | Body'nin byte cinsinden boyutu |

---

## 3. Body (Gövde)

Sunucuya gönderilen **asıl veriyi** içerir. Her istekte bulunmaz.

- `GET` isteklerinde genellikle **kullanılmaz**.
- `POST`, `PUT`, `PATCH` isteklerinde **kullanılır**.

**JSON formatında örnek body:**

```json
{
  "kullanici_adi": "ali_yilmaz",
  "email": "ali@example.com",
  "sifre": "gizli123"
}
```

---

## Tam Örnek: Kullanıcı Oluşturma İsteği

```http
POST /api/kullanicilar HTTP/1.1
Host: api.example.com
Content-Type: application/json
Accept: application/json
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9...

{
  "kullanici_adi": "ali_yilmaz",
  "email": "ali@example.com"
}
```

**Sunucudan dönen yanıt:**

```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 101,
  "kullanici_adi": "ali_yilmaz",
  "email": "ali@example.com"
}
```

---

## HTTP Durum Kodları

Sunucunun isteğe verdiği yanıtın sonucunu belirtir.

| Kod | Anlam | Örnek Kullanım |
|-----|-------|----------------|
| `200 OK` | Başarılı | GET isteği başarıyla tamamlandı |
| `201 Created` | Kaynak oluşturuldu | POST ile yeni kayıt eklendi |
| `400 Bad Request` | Hatalı istek | Geçersiz JSON gönderildi |
| `401 Unauthorized` | Kimlik doğrulanmamış | Token eksik veya hatalı |
| `404 Not Found` | Kaynak bulunamadı | Yanlış URL kullanıldı |
| `500 Internal Server Error` | Sunucu hatası | Sunucuda bir kod hatası oluştu |

---

## Özet

```
HTTP İsteği
├── 1. Request Line  →  POST /api/kullanicilar HTTP/1.1
├── 2. Headers       →  Host, Content-Type, Authorization...
└── 3. Body          →  { "email": "ali@example.com" }
```

HTTP, istemci ve sunucu arasındaki her iletişimin temelini oluşturur. Request Line isteğin amacını, Headers meta verileri, Body ise asıl veriyi taşır.