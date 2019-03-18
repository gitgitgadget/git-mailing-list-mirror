Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1FDB20248
	for <e@80x24.org>; Mon, 18 Mar 2019 12:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfCRMNo (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 08:13:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:35271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfCRMNo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 08:13:44 -0400
Received: from localhost ([94.79.149.170]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2t0Q-1gmXbs2cY2-00sf4y; Mon, 18
 Mar 2019 13:13:42 +0100
Message-ID: <273b5fcdf5a59409f1533c2f8a4d71ed99750eef.camel@gmx.de>
Subject: git p4 sync not reflecting mail address changes
From:   Massimo Burcheri <massimo.burcheri@gmx.de>
To:     git@vger.kernel.org
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-jErX39phiRfVJcx2y+Ks"
Date:   Mon, 18 Mar 2019 11:55:48 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.30.5 
X-Provags-ID: V03:K1:0p443qC9gFoULiHGLcDq0hz50nF++zRKW2bjHyWqaUcBrDnJkks
 m59jbP8ptkVjTbX9AVET9VgVsPy5e3UO6S/sAeHTGQdU2uUFHsN2kQO0kpDd29TKh0up2vS
 PIv1ZWA6NTrqDXNoRLyqoLI0t5/afxai65OvutVcymIcQBDsE/LVLSSMnKnXuwKif5Yzvix
 iJooB8se/1T682Owuxcrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UER1POzxY6Q=:ZSOzuH8hhTtpD3cpl3/lyT
 nQAoTh7lKpnhaIpBLm+vpmlsvaedY9LWoTR/lVkT3v1Iv+rbgn/QtqydW/RupIx8eO1PPoQYr
 pfuKpotwQgO259yly5Wlup5HZrblJ50Ggw3lpDO+03xfax80m5onQZ+WJI/TGCFlAghW+zHr5
 NIFFwOclGLSbtKMCcXug+C41Q6ZfXPhasqJAEK5Te33Yh40gXG1aPtc9mk9Nm6xh0FlWpRCyH
 EwOyOX82oFOMlXGzCL72CTtLwcUPaU1XGuIQ+G7NQjsZDr9G7QQtvtGpEsvoVHR47AyYYYaRW
 Uttv+Zv4EdjMHIBQ4qkajBzcLg01rX3/vE/mYCVG3NJ85AK2tjK1LkWNSQYZ7JPOhd5qPl3sr
 +SPNMYxMFJVc4A+2iLwoeZXX6zoXOPYtIF0eEFSBld2VK5PbON0adz/FDcAWp8d0EtGxZTz0z
 6L+mh0DJy/2zzhVOOwsaGzPQnNKpWconxyoH9af29jz13agTq/9Yhyff6X/b0yhfE1fR5ROXl
 P0pk8+FlsWaaXfBJJHalNA9jrSilkMHSsiYjMAudA5PZ6KLcDmRN5v/DmpKYoPGeN2fTGS9Zw
 eUlKwI1mJ/RDta0TtRLGEFyDbLMEI7+qng8N9B6gI8omhC7737/DTGGJPLLAiIQ0LNbML3q8Z
 gDeAt+3ECxf25a2JiJVEhnlrFryIT5SGih/U6o5vFrRPOHSSuAbh9TatZMvApwR+ecL/GzJpr
 cZWmZ+TtxJpMhoyeW3/fwPiVOR/UOQLzHqM6OHM16Q/+nkr+p33qJly3JOWBY0KTASbcrbCpY
 HmHHZiP7JJX1W2rMyR6Jx5hCd1VCWmbJq+DoRkoa2RhYyjO4emgMyRMn/Yup16ec/Qb3x3Dmq
 w3HupL0H9cPybnbIrO8SCtMpSFQoB28d6L9ceG/Yiu+xicGOmXzi7n7P0ZuIbL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-jErX39phiRfVJcx2y+Ks
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

we are periodically doing a 'git p4 sync' on a p4 clone that was initially
created by 'git p4 clone --bare //DEPOT'. Now on P4 side the mail addresses=
 have
changed, but git still uses the old addresses.
p4 users already shows the new addresses but new changes in the git log are
showing the old addresses.

There is
https://git-scm.com/docs/git-p4#Documentation/git-p4.txt-git-p4mapUser
to remap users but afaik there is no mapping at all right now.

I tried

   mapUser =3D SomeUser =3D Some User <some.user@local>

but also with this configuration new changes synced are showed as=20
some.user@oldlocal.

We are not submitting back to P4, this is just a readonly git p4 clone.

Best regards,
Massimo

--=-jErX39phiRfVJcx2y+Ks
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEjdL61EKP3VOAA+I8lQj3p5VSZjIFAlyPeTMACgkQlQj3p5VS
ZjJmtxAAsUvSCc2xSwFD9GLYA+37rU9f+X3Y6q7ABdBEljNHfUuh18Bz9gxpijLu
P3aPD27TB3ycrz+cgCt3RGVj9/tnU6lMH4JW6HOXm2rCr6UppJMKKz/xpBsGZ3ol
TgDhsxJFczjeDoet/eJQGHzncpiMm7h/IyMMSrLM9U1gbon+rwSOzjTQ/SWRBzVh
uxV7Ax3zFIC/5d4LEEnECWbgM1sDv/ebn/gP1iDdG5hATU70QcP1ACoF/6ldhj6r
pqhoWOr75XXBXV5pbwnkILC//cyJnaEWwMPzdh+ZkmF7gtANuDTf6S6+/yzFoMPV
o6TRVrRUh1TDgncHMaUZNS7DPAehalJOyVR0r8Ysx6lrWcsOc5ZiQOLsO74MtkMG
Q4h85VS6aZjlIxT13E7fbXaLms4cRZZ0JxUfXBdZ1994QQOxtDUZIxVEhiFH9YuN
+NX49lW50Zzl1VY9Nl1jb+2oCt1lje54uMK/ngy0UrOiejq21wqks89+5B+Lw1He
0QjWyMMKHNPUR68lc+JDSu27QLvktLqluWgyfrObKmymynk8QmcBuQKXia9z28XV
95Xc9j7IjvYGv3JHTWr/mlwew0ginERDBEk99KnrFQMGIV+YLv4F+B0IYUrJ6ENM
xzVqAxdnSDzxQDb9/+2vgHta/LXC5doTMxdOW7UwAkOUN0Z9ysY=
=wv5T
-----END PGP SIGNATURE-----

--=-jErX39phiRfVJcx2y+Ks--

