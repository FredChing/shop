<?php
 
$config = array (
    //签名方式,默认为RSA2(RSA2048)
    'sign_type' => "RSA2",

    //支付宝公钥
    'alipay_public_key' => $alipay_pkey,//"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsmfc8m+hNQqePJzBQaCfzdkGq6FinfFGM9SpfkkZYhjStdjcOUc+4OTZqa1T5u5dMpZ3Zl8rPHpUpTjrpIszdvEa3l3pBprE0Xr6e2zyj9qKJqap1FuBoPHhfXKyScwm3H5ZfEK9Yf3UrFybzb33iC/rKhJKMGhYy/VQTkSFIqpKg3c5cHeMImNsJssQKwB2e5sCpoz7X13ezZgdUucLDB9g2z/RkYzt0oU9ZZTjDuZiZPvLL/RHs9UFI8O6gvUbku8gCN5yZMHaZ6VRJhlrh/WzUe37r/G5sdhziBNeH+strW888p+8hjG0siLHmMJ7sn3AyVblwF24rbCXkd7F5wIDAQAB",

    //商户私钥
    'merchant_private_key' => 
"MIIEpAIBAAKCAQEAxlDUUNOMDGnlQe9/AdDXBRD7CrkHqGOk/CJTu43iqeKKJhA39kK9dX/AlTlizYHSx4preuLZ/Q4wRv+9fcZbWDNxaypTjJnk8V8Huwq/ZVp0J8gFIKX1ABPXGmo4VI7fm31usA6XDMsnFc8V/ScvgndQLaAujixuXjpNZLwtEfc8aJhuTvaGn1jS72+63asg6HNtS/HhqS0wPnEC1VnogsPRROIpzjMwdkTmmISB4k7STLmRRkC+myPbYZAhXxLlKgWvyrZLb6p0K2uCpKnpMdfcnMZxFD8TZ1WNHzLP13dGHncCTKY56Tm1bult56kz2gnqJ23R5kb59xojudZ3qwIDAQABAoIBABaMwleedmJC+EqTDQIL2Sc+Uw1ZFMHU8sGotZSyAYAHvmWtmm9qD1j4+dD+AXoUtP7zgl0qxla78klgcw+GKoTQ9KiW24E1To8TmzFte23u5x5O5CZeOImVt/PM+DLFPC/WB2wFfK97uioErh9nAUP4hSlq+WA5NSOJxZsaupU8MGT4MihuTtCHjUn2Mw5PGPXezpZIHRviYoLdUvfC8p/onnQGiuyZwrGPS0ZdvuVktABQtNdir9MDwGEW/JFbkH1hXFlz7Q6M0ZvqDs/pNoRdau2kBgbuWdhDIqgq0l40KiFCOwXMgSJrkOjq2tNis3d2Mr9wtu6ypsxG7pQ3EIECgYEA5pKQd+cQkwBN03x470Iz10NpijQMtvr5CRYgamOLh5exKUI2+WSTs5CX64uZvuAyjxsv3aK8dwdwGxWuuqmTOVtfhhLl3f9VWvbUhOnoUqbD6BKnoVhWoSAfpDzY0TmgoOn4fyAgE1Be3+I/EYCoN9mFriKkBz+plNKs1VnJqzECgYEA3C+anKdd8F0A53y86NvWrV+ECAUdQId4gJH9rDHX6l7M6Cj5ADXLe/Vo7sOA6RnlhjdI8MjFk+uGA3Zc4Ntri57EDzz1Kvu98F5f7q8TQ+dr7HbrJ9n9CBsRQfOdYI5/ps4b+k9OQqqOl9WjxiIbi2L7+4QNCtfBEi6JPYCyoZsCgYBvALp6bwxkqO3O1grmrMmGZdbmiR5h7Tt9a2CZt2jSE25f/Ze3wvr0pLTu2htfcFIG4UDPA+yVpUgMUgj3pnHRWDMJugleMfGmxFQV1QJa4BxKmsiG/Z9fHLb++6gqOgMh1OIkWZP3mGbEhAh25aiWkqsv5U9wie6bTj2UzRAw0QKBgQDaN5ecv8a67AF0akxy30Vwh+Q7ao4mINzNV2K4IKHjVlbvk4PLsITdckevsjR1UMQH84ynjeM6iUZE8i50byGzuwKGM5yrH9mLeozK6dpHBvkP3n+J/GHogaLl4QHM6w0aDNTvi199dLljQ0lPmQgBaXVgPOwMHe3sDhDX0k+3FwKBgQCvhM9Z7H7rXXCmwn8vtLGVqAN23wIaJGC9LuNmkRykydMmnNkmHzxfcudR/do6PicOpLst2fm49jimHU/tqXWnmFGfsDIN6oHn+h/90IIjq0eTLmoV9225HauigkhUMEgVD72pgGYIrH1GoDDyySL1PZORLLrXaX2ygQLFJPRV0w==",

    //编码格式
    'charset' => "UTF-8",

    //支付宝网关
    'gatewayUrl' => "https://openapi.alipay.com/gateway.do",

    //应用ID
    'app_id' => $app_id,

    //异步通知地址,只有扫码支付预下单可用
    'notify_url' => $notify_url,

    //最大查询重试次数
    'MaxQueryRetry' => "10",

    //查询间隔
    'QueryDuration' => "3"
);
 