From: <stefan.naewe@atlas-elektronik.com>
Subject: Re: [BUG] gitk
Date: Wed, 8 Jun 2016 09:40:02 +0000
Message-ID: <4c22a048-ad42-c831-e167-5be5540bdb49@atlas-elektronik.com>
References: <CAAoZyYNnWk-yE9TG_Fpxxs-oRN-yEsm_YFs+Ej7muQ+5YCW43w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="I7o2JdW2UQXE895Q62Jq8Lnjs9koiPhTL"
To: <eric.frederich@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 11:41:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAZzO-0003hY-CF
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 11:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424104AbcFHJlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 05:41:20 -0400
Received: from mail95.atlas.de ([194.156.172.85]:17532 "EHLO mail95.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423562AbcFHJlO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 05:41:14 -0400
X-IPAS-Result: =?us-ascii?q?A2CtBAD751dX/wXKxApdhBQrUr0CIoVxAoF2EAEBAQEBAQG?=
 =?us-ascii?q?BDIRGAQEDASNbCwIBCEICAiwGFwENAgQBDAgBAQqIGRarXZEqAQEBAQEFAQEBA?=
 =?us-ascii?q?QEUDogeglaHQYJZBYgHjVmCb4MtgWmSUIVfj2E1hA1uAYoOAQEB?=
Received: from scesrv02.atlas.de ([10.196.202.5])
  by MGW101FE.atlas.de with ESMTP/TLS/DHE-RSA-AES128-GCM-SHA256; 08 Jun 2016 11:41:06 +0200
Received: by SCESRV02.atlas.de (Postfix, from userid 600)
	id 3rPk2p1RWtz2MGjL; Wed,  8 Jun 2016 09:41:02 +0000 (UTC)
Received: from MGW201PAR.atlas.de (unknown [10.206.101.60])
	by SCESRV02.atlas.de (Postfix) with ESMTPS id 3rPk2k11BLz2MGjK
	for <git@vger.kernel.org>; Wed,  8 Jun 2016 09:41:02 +0000 (UTC)
Received: from msexsrv1.atlas.de ([10.200.102.56])
  by MGW201DAT.atlas.de with ESMTP/TLS/AES128-SHA; 08 Jun 2016 11:40:01 +0200
Received: from MSEXSRV5.atlas.de ([169.254.3.175]) by MSEXSRV1.atlas.de
 ([10.200.102.56]) with mapi id 14.03.0248.002; Wed, 8 Jun 2016 11:40:03 +0200
Thread-Topic: [BUG] gitk
Thread-Index: AQHRwPHKJWNzOr9WR06J6BpDUktSN5/fMAMA
In-Reply-To: <CAAoZyYNnWk-yE9TG_Fpxxs-oRN-yEsm_YFs+Ej7muQ+5YCW43w@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296775>

--I7o2JdW2UQXE895Q62Jq8Lnjs9koiPhTL
Content-Type: multipart/mixed; boundary="RO7nAHHogLK1nNqwmAVNmGtaxmhqLON1I"
From: =?UTF-8?Q?Stefan_N=c3=a4we?= <stefan.naewe@atlas-elektronik.com>
To: Eric Frederich <eric.frederich@gmail.com>,
 Git Mailing List <git@vger.kernel.org>
Message-ID: <4c22a048-ad42-c831-e167-5be5540bdb49@atlas-elektronik.com>
Subject: Re: [BUG] gitk
References: <CAAoZyYNnWk-yE9TG_Fpxxs-oRN-yEsm_YFs+Ej7muQ+5YCW43w@mail.gmail.com>
In-Reply-To: <CAAoZyYNnWk-yE9TG_Fpxxs-oRN-yEsm_YFs+Ej7muQ+5YCW43w@mail.gmail.com>

--RO7nAHHogLK1nNqwmAVNmGtaxmhqLON1I
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 07.06.2016 um 21:20 schrieb Eric Frederich:
> Hello,
>=20
> I couldn=E2=80=99t find any documentation on submitting patches for git=
k.
> I saw in Documentation/SubmittingPatches that gitk is maintained in
> its own repo.
> I can=E2=80=99t clone repo=E2=80=99s unless they=E2=80=99re http while =
on my corporate proxy.
> I=E2=80=99m hoping someone can help me out or just do it for me ;-)
> I=E2=80=99d like to revert 66db14c94c95f911f55575c7fdf74c026443d482.
>=20
> That commit just renamed =E2=80=9Cgreen=E2=80=9D to =E2=80=9Clime=E2=80=
=9D
> It causes gitk to not start up on when ran through VNC.
> It works fine on that same system natively or over X11 forwarding but n=
ot VNC.

FWIW, I can confirm that.

git version 2.8.3

My $HOME/.config/git/gitk contains:

set mergecolors {red blue green purple brown "#009090" magenta "#808000" =
"#009000" "#ff0080" cyan "#b07070" "#70b0f0" "#70f0b0" "#f0b070" "#ff70b0=
"}

With that file gitk runs without problems.
If I move that file away, gitk stops working over VNC and also forwarded =
X11 for me.

It runs natively on Windows though.

> It also seems from the following link/quote improper to use =E2=80=9Cli=
me=E2=80=9D anyway.
>=20
> From http://www.tkdocs.com/tutorial/fonts.html .. quote:
>     Tk recognizes the set of color names defined by X11;
>     normally these are not used, except for very common
>     ones such as "red", "black", etc.


Stefan
--=20
----------------------------------------------------------------
/dev/random says: Useless Invention: Dehydrated water.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e6=
96b2e636f6d'.decode('hex')"=20
GPG Key fingerprint =3D 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 9221 27A=
F


--RO7nAHHogLK1nNqwmAVNmGtaxmhqLON1I--

--I7o2JdW2UQXE895Q62Jq8Lnjs9koiPhTL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAldX5/AACgkQgptJxZIhJ6/S7gCfUR65Vo5ejLHDT2xxiIR7Jnuh
is0AmwVvVu8pL/Lw68J9sqWi7XTf+blS
=FVa/
-----END PGP SIGNATURE-----

--I7o2JdW2UQXE895Q62Jq8Lnjs9koiPhTL--
