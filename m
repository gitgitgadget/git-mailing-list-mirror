Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40274C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 04:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJTEeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 00:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJTEeg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 00:34:36 -0400
X-Greylist: delayed 461 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 21:34:32 PDT
Received: from redcrew.org (redcrew.org [37.157.195.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384D913CF8
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 21:34:32 -0700 (PDT)
Received: from [192.168.0.2] (unknown [185.22.237.37])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by redcrew.org (Postfix) with ESMTPSA id 25478C4
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 06:26:50 +0200 (CEST)
Message-ID: <4eb8707f-4686-e304-2aab-a6afee11abc9@cepl.eu>
Date:   Thu, 20 Oct 2022 06:26:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Mat=c4=9bj_Cepl?= <mcepl@cepl.eu>
Subject: git-send-email with GPG signed commits?
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------C8A9Q10Ac9JUxDJsqcRH65JB"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------C8A9Q10Ac9JUxDJsqcRH65JB
Content-Type: multipart/mixed; boundary="------------ts5pHnqU5vOLi4ekcKckT0Qr";
 protected-headers="v1"
From: =?UTF-8?Q?Mat=c4=9bj_Cepl?= <mcepl@cepl.eu>
To: git@vger.kernel.org
Message-ID: <4eb8707f-4686-e304-2aab-a6afee11abc9@cepl.eu>
Subject: git-send-email with GPG signed commits?

--------------ts5pHnqU5vOLi4ekcKckT0Qr
Content-Type: multipart/mixed; boundary="------------BzurZ1rAQNOaLttkjG07hyWX"

--------------BzurZ1rAQNOaLttkjG07hyWX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCmRpZCBhbnlib2R5IGV2ZW4gdGhpbmsgYWJvdXQgJXN1YmolPyBJcyB0aGVy
ZSBzb21lIGVmZm9ydCBzb21ld2hlcmUgDQptYWtpbmcgZ2l0LXNlbmQtZW1haWwoMSkgc3Vw
cG9ydGluZyB0cmFuc2ZlciBvZiBzaWduZWQgY29tbWl0cywgd2hlcmUgSSANCmNvdWxkIGpv
aW4/IEkgbGlrZSBob3N0aW5nIHNpdGVzIGxpa2Ugc3IuaHQsIHdoaWNoIHN1cHBvcnQgDQpn
aXQtc2VuZC1lbWFpbCgxKSwgYnV0IHVuZm9ydHVuYXRlbHkgdXNpbmcgdGhhdCBjbGVhcnMg
bXkgc3VibWlzc2lvbiBvZmYgDQppdHMgR1BHIHNpZ25hdHVyZXMuIEkgZ3Vlc3MsIGl0IHdv
dWxkIGJlIG5lY2Vzc2FyeSB0byBtYWtlIHNvbWUgDQptb2RpZmljYXRpb25zIHRvIGdpdC1z
ZW5kLWVtYWlsKDEpIGFuZCBnaXQtYW0oMSkuIElzIHRoZXJlIHNvbWUgZWZmb3J0IA0Kc29t
ZXdoZXJlIGluIHRoYXQgZGlyZWN0aW9uPw0KDQpCZXN0LA0KDQpNYXTEm2oNCi0tIA0KaHR0
cHM6Ly9tYXRlai5jZXBsb3ZpLmN6L2Jsb2cvLCBKYWJiZXI6IG1jZXBsQGNlcGxvdmkuY3oN
CkdQRyBGaW5nZXI6IDNDNzYgQTAyNyBDQTQ1IEFENzAgOThCNSAgQkMxRCA3OTIwIDU4MDIg
ODgwQiBDOUQ4DQoNClNvbWV3aGVyZSBhdCB0aGUgZWRnZSBvZiB0aGUgQmVsbCBjdXJ2ZSB3
YXMgdGhlIGdpcmwgZm9yIG1lLg0KICAgICAtLSBCYXNlZCBvbiBodHRwOi8veGtjZC5jb20v
MzE0Lw0K
--------------BzurZ1rAQNOaLttkjG07hyWX
Content-Type: application/pgp-keys; name="OpenPGP_0x79205802880BC9D8.asc"
Content-Disposition: attachment; filename="OpenPGP_0x79205802880BC9D8.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
k2RqtabpH9mrN7M=3D
=3DjR0O
-----END PGP PUBLIC KEY BLOCK-----

--------------BzurZ1rAQNOaLttkjG07hyWX--

--------------ts5pHnqU5vOLi4ekcKckT0Qr--

--------------C8A9Q10Ac9JUxDJsqcRH65JB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEPHagJ8pFrXCYtbwdeSBYAogLydgFAmNQzgkFAwAAAAAACgkQeSBYAogLydjG
4w/9GKyDkP5f0uZVmNVbHjjuTnjjZzyEkO0qbBy1rjCewt8DLahCUZ7z8Gs21lyLUfSniYBxE0Xk
tLp6egUISeyizP2XREkwxgHcJkAY/VA++iCab/Or65xIOfX9jByncU/DzBi3oy9+o7cKVIjgtplu
rM/ygqeav6LtwjCa4hW5MD5N4HW4qi9ZHUFKYEGgnOeUCyrU9QUV9Zv96vIM/GbByJ/R6/LYu0xO
UfHsxIQnifbbm7gE+dnBJMzUlmzwKWopycvuiUrH5WF9TraaJ3B+C7GYL64rv2MJmRo1XZBmaePn
ocFciIakevmAvfMFM6FIYNFORkoBG4vXTQixNvd1MlwomNha9ZrjW4M+o7CxUzPGqcCOR4JAYEX2
PabWZfmQa6Ds19unmqq4ILtvVlJQadviLih2wC/QJO+lXlrdxMDQLMNXkppyJ4jy5p5IcwB7ABQB
aAAjT0sEpXlSrJ/jjcgQL082tmvujBVGvxOBls7Vaivbt69oN6IaK0gxfY2+4G4ZLwONLU3VYX5g
ZCHa5AifZ17z8QRZTsHDNX51dx6VqsmPu05L0vXAHVuVvpll26nfDimYShWspTQVOvGDTQ7ZGhm3
VGQbBZETA9Pdk9MISTQM0uXSS4c5HHC2pSanDqU/zeFdp0JBUPdavJ29hzlqtu8hq6pGkAMZYetj
kuQ=
=vFRd
-----END PGP SIGNATURE-----

--------------C8A9Q10Ac9JUxDJsqcRH65JB--
