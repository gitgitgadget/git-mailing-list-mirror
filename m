Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FCB61FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 14:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755411AbcLNOIs (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 09:08:48 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.27]:37177 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755281AbcLNOIr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 09:08:47 -0500
X-Greylist: delayed 915 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Dec 2016 09:08:46 EST
Received: from [109.91.33.242] (helo=wind.local)
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
        (Exim 4.84)
        (envelope-from <jh@ht-studios.de>)
        id 1cH9zp-0002jb-OL
        for git@vger.kernel.org; Wed, 14 Dec 2016 14:53:25 +0100
To:     git@vger.kernel.org
From:   Jonas Hartmann <jh@ht-studios.de>
Subject: git stash filename - stashing single files.
Organization: =?UTF-8?Q?HT_Studios_=c2=b7_Custom-Tailored_Software-Engineeri?=
 =?UTF-8?Q?ng?=
Message-ID: <b528e23b-c763-846e-4040-504a58b690fd@ht-studios.de>
Date:   Wed, 14 Dec 2016 14:53:20 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WW3Bj25AH5QiCsoTk86rif8NwtmkQJsQN"
X-Df-Sender: amhAaHQtc3R1ZGlvcy5kZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WW3Bj25AH5QiCsoTk86rif8NwtmkQJsQN
Content-Type: multipart/mixed; boundary="5ecb6dxtWMoP1F42RqVlXATF6cqGlKdUX";
 protected-headers="v1"
From: Jonas Hartmann <jh@ht-studios.de>
To: git@vger.kernel.org
Message-ID: <b528e23b-c763-846e-4040-504a58b690fd@ht-studios.de>
Subject: git stash filename - stashing single files.

--5ecb6dxtWMoP1F42RqVlXATF6cqGlKdUX
Content-Type: multipart/mixed;
 boundary="------------72EAB9167F45F620D8D0F303"

This is a multi-part message in MIME format.
--------------72EAB9167F45F620D8D0F303
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

http://stackoverflow.com/questions/3040833/stash-only-one-file-out-of-mul=
tiple-files-that-have-changed-with-git#comment32451416_3040833

Could it be possible to have "git stash [filename][filename]...", to
stash only single files?
There seems to be a broad community desire.

Best

--=20
Dipl.-Soz. Jonas Hartmann
HT Studios =C2=B7 Custom-Tailored Software-Engineering
jh@ht-studios.de
+49 160 9924 4679
http://www.ht-studios.de


--------------72EAB9167F45F620D8D0F303
Content-Type: text/x-vcard; charset=utf-8;
 name="jh.vcf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="jh.vcf"

begin:vcard
fn:Dipl.-Soz. Jonas Hartmann
n:Hartmann;Jonas
org;quoted-printable:HT Studios =3DC2=3DB7 Custom-Tailored Software-Engin=
eering;Founder
adr:;;Mainstr. 93;Pfungstadt;Hessen;64319;Germany
email;internet:jh@ht-studios.de
title:Dipl.-Soz.
tel;work:+49 160 99 24 46 79
x-mozilla-html:FALSE
url:http://www.ht-studios.de
version:2.1
end:vcard


--------------72EAB9167F45F620D8D0F303--

--5ecb6dxtWMoP1F42RqVlXATF6cqGlKdUX--

--WW3Bj25AH5QiCsoTk86rif8NwtmkQJsQN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYUU7SAAoJEFrqf3+XGp9iggsP/16FX0XgTtCXqlvkHcQeuxbW
UPvUiTvX8dv3ZutOHJX2163g8q7+CYI1KfKj60ed3ImblLHAx1SY09VqzKGbW7jM
0+nHx9/hI7RcW8jxyAds4hkiIKqMJwdK+Gx1h8ohDEC92yWpzO70RJrMKWC9jV2m
KPoGKTTUjgfNESyOxwkPXIaw2BbixFDLd6cgwoVMlDHE3VM++dOuuX+tvAq6uPVT
vRGR9oSAt2XRlORye0gmfTWED4dF9Uzgk5ZKGZBQoAu24oi2XmX99ra4jLr93oLm
+WUNERBynUMSpvAN131N5QK8oLMEfOhAcTS2qJiYOdmThtOnSflYolEdpQPuBUcC
3Sy4nPd7BCotlNgYG7BijU1t0rF4jby39JNbnJb2Pq4KUV4typ7+zToFSl9rp18D
ugfAMjFdOHAapWCX8lQuo5TWC+l9tIYjaK+sbkHyj/mJtAGLHBKeu2el0g14U743
13ibwsVPAMDVjwEUBrOX5Owsp8nNAfv0n7gil0l3XTNeL8GcDiTuSKbo12W3XDWb
y/TquJmroDiSmeI3x/fkp8MySDGm23mDkpwiorYU3ehmSowJlLKkp9UZLiBHw7kq
15TIX0wjMSgfUAQDiw3GWChcu3AEfts/4C5nxWObW04oqYzkZr0mSDJNUh9WOOQH
fO4Gt5trBGEAf6a1mttO
=xZ0w
-----END PGP SIGNATURE-----

--WW3Bj25AH5QiCsoTk86rif8NwtmkQJsQN--
