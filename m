From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Fri, 16 Jan 2009 10:11:01 -0600
Message-ID: <200901161011.05614.bss@iguanasuicide.net>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901160253210.3586@pacific.mpi-cbg.de> <adf1fd3d0901160102y32a08e26q96728495fc0b6fcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6165166.zn00HUJUig";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 17:12:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNrIb-0002pK-T7
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 17:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755435AbZAPQKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 11:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755398AbZAPQKb
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 11:10:31 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:39980 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949AbZAPQKa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 11:10:30 -0500
Received: from [206.104.160.106]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LNrH4-0005DY-CG; Fri, 16 Jan 2009 16:10:22 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <adf1fd3d0901160102y32a08e26q96728495fc0b6fcf@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105971>

--nextPart6165166.zn00HUJUig
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 2009 January 16 03:02:33 Santi B=E9jar wrote:
> 2009/1/16 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> Hi,
>>
>> On Fri, 16 Jan 2009, Santi B=E9jar wrote:
>>> If everything works as I think (it's late night :-) with the above two
>>> lines:
>>>
>>> matrix[a,b,c]
>>> matrix{d,b,c}
>>>
>>> the word diff would be
>>>
>>> matrix<RED>[<GREEN>{<RED>a<GREEN>d<RESET>,b,c<RED>]<GREEN>}<RED>
>
>So, I see, it is a matter of finding the right regexp.
>
>But the only use case for me is of this kind, and I think for the
>others too. So maybe an easier way to specify it could be worth. But
>I'll write an alias as this is the only regexp I would use, apart from
>the default word diff.

I think that the C/C++ language word-diff driver would work here, and there=
=20
should be a shortcut for that.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart6165166.zn00HUJUig
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklwsZkACgkQdNbfk+86fC3YgwCbB9pKFb6mBp87NoMVB4UTq0ua
XLkAnA1doYU+jfaW9sgtVmTpTp9ieL+J
=k2gj
-----END PGP SIGNATURE-----

--nextPart6165166.zn00HUJUig--
