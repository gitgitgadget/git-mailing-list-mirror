Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC45C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 10:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhL1KPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 05:15:00 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:51565 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbhL1KO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 05:14:59 -0500
Date:   Tue, 28 Dec 2021 10:14:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1640686496;
        bh=SCVWqs4ycpL5IJIM3SOFOQQvHMtXrT/jUeeAyafX9pQ=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=m2Qyn7+1Y3X0MfGCoNb22H9pARRUlh5Rn8YPrASfkFYynK6l5MvHFqon9XKmfJmdr
         Rr45P5QSdXxeKWHUA5ciD8iKdIEtdUA7kfou+BEKN20dZi46KREHGu4KXgWjFqx4oG
         ksxJ6XPG6X0KQMc5l5gEvLa2rD6/NSlrZ8pmK6WEh4191mxUPK0Y367x+BpAedR39F
         B0LQ8KSGhAdPY/xpi4c8Ba9eVMG5flMdNK27RN3eh9xtOY2Jld24aX1uQnVwQgZXFB
         fYO4KPUtKcZMls2cBprSNb9xAHydW0Gk5o3SW4Vlnv5ptSi1LNUJF9VGXd9IgliJdj
         PoI+SllV9M/eA==
To:     rsbecker@nexbridge.com
From:   zhiyiren2009-subscription 
        <zhiyiren2009-subscription@protonmail.com>
Cc:     zhiyiren2009@protonmail.com, snakamoto1975@protonmail.com,
        git@vger.kernel.org
Reply-To: zhiyiren2009-subscription 
          <zhiyiren2009-subscription@protonmail.com>
Subject: RE: Quick login of git
Message-ID: <2f__vvSlzZu3D0TmU1T99eXORo1_l-r6YGrjDu_Nmu3XUnx5KLBKbjxr-zYSkq4JeCyruyKcpRgMehNqCrBQzNbAa1R6eTRNWtYZCNCDx2M=@protonmail.com>
In-Reply-To: <000801d7fb5b$12ec49f0$38c4ddd0$@nexbridge.com>
References: <7w7c2MDOBpV9yIlD5yZZb801w-eaz0qhErkCN-De51h892xRFL14N-LCXH0O8wvDp_51A3hC86EMXonBkjNdoTZ-iy8xzoKLVecN6D6Zpq4=@protonmail.com> <004601d7fb3c$c9d359c0$5d7a0d40$@nexbridge.com> <J-VncZqqtXGSpnkopiYEtOET-oeVZX1tk3jBX9c3oSaOrcH1N_ciDdzQFvk50CkibrWFCboQNDeegBNMGZ247duUXwnPFY_0HbFvEWI0hVg=@protonmail.com> <000001d7fb3e$7c0e8730$742b9590$@nexbridge.com> <FKMNcEoH2PMBw4wcDkxzCDdl41kpWkZyh5SkiRlDi6seiVchbCuBbMmc38SFYR8gAgDhk_vo3xJSCiPSdYRIvhOQ1cB4uoZksClDYey2LXs=@protonmail.com> <000801d7fb5b$12ec49f0$38c4ddd0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------8aef16b9ae7d2b105648a5d3794b1df41d81de2c24b63e9cca0b08cdbc55c46f"; charset=utf-8
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------8aef16b9ae7d2b105648a5d3794b1df41d81de2c24b63e9cca0b08cdbc55c46f
Content-Type: multipart/mixed;boundary=---------------------4591f35e0a29470506997f9e58f6bcb8

-----------------------4591f35e0a29470506997f9e58f6bcb8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Sorry, I made some mistakes when I typed. This is the leatest vision.

Some IDEs (such as VSCode / CLion / Idea, etc.) can login to GitHub / GitL=
ab in browser, but git cannot, so git should change itself.
And I was suggesting changes in GitHub Community but they told me to sugge=
st on Git Community.

Zhiyi Ren / Subscription Mail
zhiyiren2009@protonmail.com / zhiyiren2009-subscription@protonmail.com

Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original M=
essage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Tuesday, December 28th, 2021 at 03:50, <rsbecker@nexbridge.com> wrote:

> -----Original Message-----
> =


> From: zhiyiren2009-subscription <zhiyiren2009-
> =


> subscription@protonmail.com>
> =


> Sent: December 27, 2021 2:16 PM
> =


> To: rsbecker@nexbridge.com
> =


> Cc: zhiyiren2009@protonmail.com; snakamoto1975@protonmail.com;
> =


> git@vger.kernel.org
> =


> Subject: RE: Quick login of git
> =


> Visit the url provided by IDE in the browser, and then click "Auth" to l=
ogin.
> =


> Wait a moment, GitHub will return a token to the program, and you can ea=
sily
> =


> login to GitHub. Popular IDEs have this login method.
> =


> This configuration is much faster than the terminal, and it takes less t=
han 1
> =


> minute. But it takes 5-10 minutes to configure by terminal for the new u=
sers.
> =


> Zhiyi Ren / Subscription Mail
> =


> zhiyiren2009@protonmail.com / zhiyiren2009-subscription@protonmail.com
> =


> Sent with ProtonMail Secure Email.
> =


> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original=
 Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> =


> On Tuesday, December 28th, 2021 at 00:26, rsbecker@nexbridge.com
> =


> wrote:
> =


> > On December 27, 2021 11:24 AM, zhiyiren2009-subscription wrote:
> > =


> > > On Tuesday, December 28th, 2021 at 00:14, rsbecker@nexbridge.com
> > > =


> > > wrote:
> > > =


> > > > On December 27, 2021 11:07 AM zhiyiren2009-subscription wrote:
> > > > =


> > > > > Why not add a quick login method like VSCode and CLion in git? L=
ogin
> > > > > =


> > > > > to
> > =


> > > > > GitHub/ GitLab with one click, without privete key.
> > > > =


> > > > I am not sure this has anything to do with git itself. One does no=
t "login"
> > > > =


> > > > to
> > =


> > > > git. You might want to take this up with the GitHub/GitLab support
> > > > =


> > > > forums.
> > =


> > > > However, one-click login is being replace with MFA.
> > =


> > > Did you mean Multi-Factor Authentication=EF=BC=9F
> > =


> > Yes. And please place replies at end on this mailing list. Thanks.

Please use the proper place for suggesting changes.

For GitHub: https://github.community/

For GitLab: https://about.gitlab.com/support/#contact-support
-----------------------4591f35e0a29470506997f9e58f6bcb8
Content-Type: application/pgp-keys; filename="publickey - zhiyiren2009-subscription@protonmail.com - 0xBE2BD471.asc"; name="publickey - zhiyiren2009-subscription@protonmail.com - 0xBE2BD471.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - zhiyiren2009-subscription@protonmail.com - 0xBE2BD471.asc"; name="publickey - zhiyiren2009-subscription@protonmail.com - 0xBE2BD471.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQpWZXJzaW9uOiBPcGVuUEdQLmpz
IHY0LjEwLjEwDQpDb21tZW50OiBodHRwczovL29wZW5wZ3Bqcy5vcmcNCg0KeHNGTkJHSEp6WGNC
RUFESWxmb01XNG9GL3RJSEJxZDRvcVpPN1lwTzFSMmVCOENmQVpsejd6OHY2bVM3DQoxUG9abENN
Q244dW5oYUhqbmdGSWV0L3dCNENnMXBHeUQ4SEorU2loeTZoVUQrTThLNjR1ZjVFZEJ1WjcNCmVy
LzNRT0R1eHltTjlvN2ZlN3lSSFlIOThKUmV6OU9IU3lmT3M3Q0lFRkhjVXoxVkpTRkQ4Q3MyZFlk
WA0Kdi9wdUI1TjhrTWRXb3QzWHJjcWsyS0Q1UjZxdCs5RHM3dXBWcWRyY3hmVWN1Vk1OUzk3WmpX
Qm9TQzVQDQpHa0lXK0kzd2RIVjB6QitGZ1U2dWR4aGg0R1FqUFo4a3hKS1pKYVhOYW5DSjd1K1Q1
b0pnY283WnVJb2oNCkpUQ3ZmRzZ4SlF4OGIrbllPaGhPWUFjYUsyQzhGVnJpbW0xcE5rQUhmSVZF
V0JQc1JpRWFOQm1MWW5Gag0KSm9JY3N2WWd3M1F2aW9XY0dYY0FnZlNmRzNaN2lkRk93a2hsUWY4
OHJLWUNweFlhWGx0cUk3a0VFTDUxDQppRy8vamwyOTYxNTdkYVNrOVRJaDVJbUdIZGhjUkJVdTdm
cW5NSDVnbjlrcGJvaFlCUUtYTGdpcDloaTYNCjRZSG1TYk4vWjFCWnRkWE9GRk40OHB0U3lsU09O
cEU4cTQ2STJwaXE3dU5CbHQyRGdSZkN1Q2RSeklzbw0KWUFBNHd4a3JxVllIL2w3MklOZ2tORVpW
TmdSeHVoQllNME81SDJKbC9DV0JwUlVUNDJFVkZ2U3h3Qm1TDQpFT1hCYTM0d0UwaWtNdHV6YUdr
eE9IWFJ1bTNvL0FLM3V4SFNDL0JYd3N0WDljTWkvNFM2eXVHMjVYcEkNCmFOMDlWTEI3d0dvZGVi
NEFyMDNlVEw1MGxvL1VQUjRPQlJaNWNRQVJBUUFCelZONmFHbDVhWEpsYmpJdw0KTURrdGMzVmlj
Mk55YVhCMGFXOXVRSEJ5YjNSdmJtMWhhV3d1WTI5dElEeDZhR2w1YVhKbGJqSXdNRGt0DQpjM1Zp
YzJOeWFYQjBhVzl1UUhCeWIzUnZibTFoYVd3dVkyOXRQc0xCalFRUUFRZ0FJQVVDWWNuTmR3WUwN
CkNRY0lBd0lFRlFnS0FnUVdBZ0VBQWhrQkFoc0RBaDRCQUNFSkVMVzdsdXp3L1JRTUZpRUV2aXZV
Y1RpOQ0KbkhIRGlMK1J0YnVXN1BEOUZBeFRoZy8vYWVuY29Hb1JtVDlSVnZOOStDUXlGUTdxN25y
d2dUODZvYWJJDQpFKzlmMExtTVZKMXFTNGhoUVg4SmQ1TS9KUmZHQjJ3d09lb1MvR0VaRFM0RU5H
TEZ3dmZzZnc1Y25uY3INClhUSTlwcU5JWlVLNUJhTmMxVGRSSEtVNDNyeTh0WWc3cEdOdU1SWmNB
WTRaVHpUM0poZ2hYT3BmSEUxWg0KZThyL0hFcEpRQ1ZtWWNGSERPajUxL0Roc0U3VENQQ1Zmcysv
aTZTVWxGOTFGaDBuTlpJR3ZaaDRHc0xNDQpZb3BzZXczRUo1dlVDeTB1bGtVbTBLajdmYmwwREE5
YTJMRWQreXNWRHVvZFFic2pIZDBMQUVYeVI5Z2wNCjB1bzJwQWdNRkc2VEpnUUJ3OUJrUE1PSGtv
TW5nc0pUVkxjMnRVM2dpeFB1bk0razhWdmd5dDU4eDYwYQ0KL1IvVDJ1WXVwL3lGVFI4amVZOW9O
Y3hPSTFvS2NTNTFDTVRNZUFoT0JzdzNXOVphRDV2cjRseE1kYnFzDQpRMUJ0TTQ3TFpibEZrdHV3
NVBjY0N3VjlYaHpPaW1VZGZIaEtDZzg1YThwMFdkSWV2QzhRS05aNTZ4U3gNClVRTXhhZnpYMHNm
UXhJVm02ZTh4bThCRGxRVFBSVjZhUDN6K0Q4aXdhRm1pT0NDTVA4SmhPZDlVVzlmWg0KWDQzWC9C
ZjRWV3BTcWdZd0hzT3lmVGVNZzU3cTY5eE5TYmlpYUg5cVdZb3E4cWl5ZWxJSDQrc0Rod1lXDQpk
VHVBaVBYd01PR1htUFJrYjh3NExrOHE5L0srMHgxRzMzejJaRHdwUi9FZXFPOHY4Sk5zUy9TblVK
aFENCldBUEtGeWE4dUFoaUZXUklYdldRWXRsYmFoZEJ1VlpGSnYyYndoWHpRRllicEJ2T3dVMEVZ
Y25OZHdFUQ0KQU1HRFR6RE9UM00rcER3ZUtIejh4UnUvMi9uK0hNeDUrQnJHOGFTRkE3dXFwMFNF
R3JMbU1HV2FvU24zDQpSanUyOEEzcFgydElFWEh6TG9GOC9ISXdRSnpscXJDVzdQV0dYSnkvYW1t
a2JHTmZFTld4d1psWU9Wd08NCmlqTzlPUC9ZM1dqUlMzdkZDTXpHYndvUkxPY0VKUmJoNFNwWXJp
d0MxRWNlcjJGNURnb0YyT2dLTDRYUA0KbW5aS3ZuN0xHLzN4Y0JpZnpoVldGS2V6NitDNDYvRlVz
OWZvZGk1T24vQWs3MUVkRzd0Z01OSDAvNWZCDQpieGJLVHVLT3BDdFNiZVFNUUMwbWJjbGdVbWF2
UjJEMmRNQ0NWcFQvYXRuUUdsQUZ2ZUpnK2tOTXI1clUNClFDMmFZTUliVXN6SnhqUDkyZnlhTGFz
L0t4YkRLOGIvQzROOUhlbXg1QnFYODBVQXY5RFBIUzlEUE1qSA0KZ05HakhCNFNGSmtaV2UrM09i
dHA0dWx2bTlOejY0OXltU0xxWi93aERsS0lPaFdZK05nVEkwdTlteHYvDQpUb29NeFFXcFJOMDZ1
MzRwbWJPbHJLSHJzNUlhNnVOVlFZNmdhc3JHaXNjem5tbTBoc2NXYTROMHNFODINCjAyRGxpQXJE
TTY2U2gxdnB6VmVYU2dySUpCcnRTcFYxL1FyNlhFL1ZBck9FZUYyUHlxS2NnbkczQ2sveA0KSlZF
ejF0dENhdTJQTHd6eVNrMUZybWNEekZ1UFc0dDdWMUYzalAwc24wUVZRbjIwQlJIbHJyY3pVMExZ
DQpmVG9vSVE2ZXRaZzNWMEl5Q3c3V2VXV0FrNDNUUzRHSFBRRzEybHl5ODdIT1V2aXpEMFpnNC9v
OFB0aGoNClB6RTBFUXVzOE1MQ3F4ZEUyL3gyVWhaakFCRUJBQUhDd1hZRUdBRUlBQWtGQW1ISnpY
Y0NHd3dBSVFrUQ0KdGJ1VzdQRDlGQXdXSVFTK0s5UnhPTDJjY2NPSXY1RzF1NWJzOFAwVURKU3hF
QUNicXdOUUZwMDJQV1pHDQpFVjhSd2x2YXFnMUJOcjRlaGhRZWVhZTFPZXdneW8rRFZiM0c4SHkx
T29uc2h3WWtjNmNtbU16WDMzUkENCmdJSDJ2dDNGNEY2UzFHVEM3cWlzOWlnTFptOXVGaUtVd01V
UmZJMHNrY2RyUk1QWHQxQnJ1THFtd01IUg0KOVhXQ2NQa2VXOGtMbURCZ1RtamZlMngvTDZrRG15
T1ozcEx2Mm9DNE93ZG5mSi9tMTNpb2ovRWF6cHlSDQpvUjB2dVJVbzVJZklVSE5oVXgvd2VLSEhI
RHkraHJYOWpiSklvQXFRd1Q5MS9yWGlGaVI1c2VIdUhjNmENClUvU0QrUW93a1RwZ3pvYUJGOCta
WjlmNTEwT01uTEdpZmVlZDg1Tm5OQllRN3ZBTkZPYU0yTHR2WUhGdA0KNmV1NmoyZWxTWTM0YlVD
SW83cEJXTFp5clZOUEh1TmM1WmxXdTd0dFBtM2xsSWdtNWc0UXI3VStUczBJDQpWdVVCbzZTcVFq
QXZlWEhsMWEreVFydlhmS2cwSzhmaEdtV3lvQnF1M2RRZ2RHSWZqSDd4N2Q2c3hTdEgNCmdUYXB3
OXVZdnFTbGg2QzU5clNpZmFHZ2pGaUZwR0ZOVVVWcCsrWitISEkvQkRJYVA1ekc4MjU5WlNZbQ0K
VUlJUS9aRjM4elhmNGU0RWdZUWVUbVVMcXZMc2J2dVV3dlkwRWJDMzhud09CUVA1MlVWb0dadC90
bE9tDQpNTmhHd3NBd1QzdG42NGVyVTRUK2puTEZYT2kzNTRQeWQ0MG40b0QvaTJZLzZNWjVoSXNs
K01CbTVjc3UNCkhPLzdHQlVHclpjcEJFSUp3Z2Rab0RCRzQ4WFA4SjhLSk1MVnJzRzhFRUZkbXcw
RytzWWlMMEN4WFRwZg0KekhqSm92MzBWZz09DQo9SDArdw0KLS0tLS1FTkQgUEdQIFBVQkxJQyBL
RVkgQkxPQ0stLS0tLQ0K
-----------------------4591f35e0a29470506997f9e58f6bcb8--

--------8aef16b9ae7d2b105648a5d3794b1df41d81de2c24b63e9cca0b08cdbc55c46f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsFzBAEBCAAGBQJhyuOOACEJELW7luzw/RQMFiEEvivUcTi9nHHDiL+RtbuW
7PD9FAwkZw/+OBoGHPCq/bEc9O9eYfuZIRFc7YsU3qeuJuD4q6nc17/va4/2
vZeVYNfUMoVYeoQtEG9uI4VU3m0/3WyAvvjwy7GZoFSKFeJC/xQlftmiIHFr
6PCa3ry4P5bamNsDarcEpEUBy05Rd326axaSlz+tfoQXaRorwkDa18Ui1oyd
lzLuGZaxnhGNZdpAmO34TI5Yqp578n2DI86rZFEglfS8xZV6HK/ATXMsKuD/
/d2Ns+yzPMb2NpVhKBAqXX70yA5jddrCmc2Rwu+VQQIBFxHs/VsXdwXfjK48
ius4QNMZnE/j2R4PQbtNqxV4UlynVLiE7rVcLVN7Fxi1hGV3WB9mZHp1ppQw
05jaM8lYwiAYfYwMdIHcEYrhM+pItk93JUhsn7c03dW2WErJtScqNejrB7z7
3PUf4uJ/95PxWMWpa1IVQdTajE2SR49BpVj4RviFEsfwc9UrL3uOqeeyUYi6
eeTpGLTecegdgeDJsbeRFrS4ArRRp+PH/37n6pJIglsNnWD8fOrH9KMGBJMW
KhQs+5OG+3ruMqCxBzodpwrEJSgkTSxjPH33pU0Ovfogfq0K9I7YWDKpR26P
DpMA5lQaaPvIzylI4heX5UQkKQe+7nkNfRttz5aeP4u0J2w7r4aj46dPoG0Z
sTt2gWM/c+vhXorKi3zKpnMKmi5L7MSO/3E=
=2xcJ
-----END PGP SIGNATURE-----


--------8aef16b9ae7d2b105648a5d3794b1df41d81de2c24b63e9cca0b08cdbc55c46f--

