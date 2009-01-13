From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: Removing options from build
Date: Tue, 13 Jan 2009 16:10:22 -0600
Message-ID: <200901131610.22732.bss@iguanasuicide.net>
References: <1231883002.14181.27.camel@starfruit> <200901132253.15370.trast@student.ethz.ch> <1231884045.14181.36.camel@starfruit>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1793210.mnjJoHjcQx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 23:11:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMrTT-0002L6-H1
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 23:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825AbZAMWJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 17:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbZAMWJl
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 17:09:41 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:34245 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbZAMWJk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 17:09:40 -0500
Received: from [206.104.163.94]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LMrS6-0000is-9u; Tue, 13 Jan 2009 22:09:38 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <1231884045.14181.36.camel@starfruit>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105551>

--nextPart1793210.mnjJoHjcQx
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 2009 January 13 16:00:45 R. Tyler Ballance wrote:
>On Tue, 2009-01-13 at 22:53 +0100, Thomas Rast wrote:
>> IMHO your update (or pre-receive) hook should just disallow
>> non-fast-forward updates.
>
>Don't merges count as non-fast-forward updates?

No.  If there is a chain of parent links X ~> Y then updating a ref Y -> X =
is=20
a fast-forward.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1793210.mnjJoHjcQx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkltEU4ACgkQdNbfk+86fC00zgCdHwPLVY6dhjY4MDTYpRfshS2v
rPAAnjKdbHL2iv1jsck5IB2YiXnVLEza
=q8zF
-----END PGP SIGNATURE-----

--nextPart1793210.mnjJoHjcQx--
