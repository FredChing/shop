<?php

$public_key="-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCaH5OgBIixhbTrqCAqX14gb7p6
ZuJq3Pj5g+SpcAuGpK2jaBrOVnrbMiK+RX0nZ3HZv9OI8p6q3CmYyBvUgsCk++ab
a5RdW5g+Zb9skPej7nlHc37GLN193XGSjvqkSzPw9RoYgE8U4h7WyvduMq30i4dk
eLy6nC3M6haUf5WBLQIDAQAB
-----END PUBLIC KEY-----";

$private = "-----BEGIN PRIVATE KEY-----
MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAJofk6AEiLGFtOuo
ICpfXiBvunpm4mrc+PmD5KlwC4akraNoGs5WetsyIr5FfSdncdm/04jynqrcKZjI
G9SCwKT75ptrlF1bmD5lv2yQ96PueUdzfsYs3X3dcZKO+qRLM/D1GhiATxTiHtbK
924yrfSLh2R4vLqcLczqFpR/lYEtAgMBAAECgYAAtJxMYzjs9xu46HAdQYqAw4Ir
BUWMD67kFYJ6dBTZbO+Oi+9zelndnwEhtde40nRm9sXVHqczSQa3uFLISkDvfpMu
0qDE4inoApvKIIQZA4ktvazHoBaixRgul4OmXkTOlmAINGFW9wUbiF1veUgZdpcJ
iIW0paeyK27nf3vW0QJBAN5fn+B9gFoilEWdaFifJiWXjC0MumQ8gb2wYevAs2L7
ARuIVIFtb9dE2fwWunVOTXd5rGr/gwYh2IOpgxVxMO8CQQCxbeWEnGZzIeO2fYx+
IJKTz5NLHwQ3Vt2iWw7Dclx/HOZOzQEVdPoRnchZ/49Jrzr4UeFjuM5RfL6HpJfp
ADejAkEAhRx8mWbGtC3Kz7kfwxzROuNyl2ztDh9iEmhI1VRujStvSEndO/SEZDnk
uo/oYVvT51bALPRyO/N6paWMwAMXpQJBAKm9kgq4uUZB0KBgIcz0CmY/+hCu3pC2
mJfe9xPBz32Hv0j51KSbYTUDNo3q8EC00/yGENMfFLpeVcRckTvGCnMCP3he14wK
9lOENAxmvSwISH4RQRh0FI8VBbDy7EJzykHYzhxvC5Fp0B0/N2aWXtsPD51Cq+/9
6nHrOruDzsZO7g==
-----END PRIVATE KEY-----";

function getBankCode($bankid){
	$bankcode="";
	if($bankid=='ICBC') $bankcode="ICBC";
	if($bankid=='ABC') $bankcode="ABC";
	if($bankid=='BOCSH') $bankcode="BOC";
	if($bankid=='CCB') $bankcode="CCB";
	if($bankid=='CMB') $bankcode="CMB";
	if($bankid=='SPDB') $bankcode="SPDB";
	if($bankid=='GDB') $bankcode="GDB";
	if($bankid=='BOCOM') $bankcode="BCOM";
	if($bankid=='PSBC') $bankcode="PSBC";
	if($bankid=='CNCB') $bankcode="ECITIC";
	if($bankid=='CMBC') $bankcode="CMBC";
	if($bankid=='CEB') $bankcode="CEBB";
	if($bankid=='HXB') $bankcode="HXB";
	if($bankid=='CIB') $bankcode="CIB";
	if($bankid=='BOS') $bankcode="";
	if($bankid=='SRCB') $bankcode="";
	if($bankid=='PAB') $bankcode="SPABANK";
	return $bankcode;
}
?>