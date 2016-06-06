From: Daniel Campbell <zlg@gentoo.org>
Subject: `man 1 git`: Invalid link to online documentation
Date: Sun, 5 Jun 2016 20:59:00 -0700
Message-ID: <ed8f000f-b8a2-ca92-e0f2-e26ff9928bbe@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gLrkLiiH6ULk05Q4wFMQVR3bFvuqGLjuP"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 05:59:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9lh2-0006f4-Tt
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 05:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946AbcFFD7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2016 23:59:05 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:58800 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752534AbcFFD7E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2016 23:59:04 -0400
Received: from [192.168.1.2] (c-73-53-75-119.hsd1.wa.comcast.net [73.53.75.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: zlg)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 59F053408A6
	for <git@vger.kernel.org>; Mon,  6 Jun 2016 03:59:02 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296483>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gLrkLiiH6ULk05Q4wFMQVR3bFvuqGLjuP
Content-Type: multipart/mixed; boundary="uVaBT6gjON2EXjMLQXHgb3WwxfUMQHaq8"
From: Daniel Campbell <zlg@gentoo.org>
To: git@vger.kernel.org
Message-ID: <ed8f000f-b8a2-ca92-e0f2-e26ff9928bbe@gentoo.org>
Subject: `man 1 git`: Invalid link to online documentation

--uVaBT6gjON2EXjMLQXHgb3WwxfUMQHaq8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In `man 1 git`, the Description section outlines an address to
pre-generated documentation [0]. That link returns a 404 error. Playing
around, I found the repository at [1] and found that it hasn't been
updated since August 2015. Given that 2.8.3 is more recent than that, it
seems like this is something that should be updated (if the
pre-generated docs still exist somewhere) or removed altogether.

Also worth considering is Google Code was shut down earlier this year.
While archives exist, it can't be relied upon for future use. The
closest approximation I could find that was up to date is [2], though
[3] is a repository that's even fresher than 2.8.3.

Since I'm not familiar with Git development I figured it was wiser to
let you know instead of making a decision on what to do and patching.

I know this is minor but I figured it was overlooked. Thanks for reading.=


0: http://git-htmldocs.googlecode.com/git/git.html
1: https://code.google.com/archive/p/git-htmldocs/
2: https://git-scm.com/docs
3: https://github.com/gitster/git-htmldocs
--=20
Daniel Campbell - Gentoo Developer
OpenPGP Key: 0x1EA055D6 @ hkp://keys.gnupg.net
fpr: AE03 9064 AE00 053C 270C  1DE4 6F7A 9091 1EA0 55D6


--uVaBT6gjON2EXjMLQXHgb3WwxfUMQHaq8--

--gLrkLiiH6ULk05Q4wFMQVR3bFvuqGLjuP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXVPUEAAoJEAEkDpRQOeFwC9cP/iyBoimU183K5yAaPJBNzBSD
nv+lDAUY9iZshrfhEIoOTUhj6jb0vKsJJbNuleU5E9jWstemQ4zUzmO9HUBzAFEK
MmlIOr4+UBs/NM1wmmdikR41hmZJQRjG7cYW5ZM39fFrL+vTkYE4De14sqnX2iCL
4iWtdZj+bKyN0qIMOyRdfMhAyDpwWYbnjlPxLuRGj+Ra+spEIgfs5D39hDCjS0+R
u54ZH1qaOlR28sTkthNBth3DyQbLCPA0BbFMcQqvMIrxQQj3J82JCOgCLKZCZIeU
g3IKK+nHiWwmiFltaz5eIjFgZMpAopf5h0fP1L1cJlsLLreyYgOhOsq6DJ+cdbL0
3QSfRZNoI33zL2nrLZ6d5wQW6xCr0SZONTC8WukWeJnWYY4MlcVLrTX0Phv+rpxO
Stybe+luUvd48vEL7SsG42Jxp1S+tA2kFqT5Z1dOQWPpi99IBfvXly63eJYYDtFx
sNZ/qP9eDLQfoqtLyLMmAAF/Np0ns6TWwpvXtb/jYzFUTPUvBHp2F6x6SqO2j99C
Qx8Gk1mvx5xVVtxxjspBHCNzn4G+Y1HPHbtFWEYSkOjOGoDxTZoURoikX9n8uWrr
v1ryT/Ih8AtGazUAegzem5LPEk3asvIhpEAVof1/wu1nMYrawkFLEUQO5mKHq3IE
TzTe4mRexi3yt+O512RU
=whls
-----END PGP SIGNATURE-----

--gLrkLiiH6ULk05Q4wFMQVR3bFvuqGLjuP--
