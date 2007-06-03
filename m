From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [PATCH] gitweb: use decode_utf8 directly
Date: Mon, 4 Jun 2007 01:13:51 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200706040113.56055.ismail@pardus.org.tr>
References: <200704241705.19661.ismail@pardus.org.tr> <200706012308.41335.ismail@pardus.org.tr> <7vmyzgn14w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1786862.qHtQhWQD9R";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 00:14:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuyKu-00066a-IT
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 00:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbXFCWNv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 18:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbXFCWNv
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 18:13:51 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:60866 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751173AbXFCWNu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 18:13:50 -0400
Received: from southpark.local (unknown [85.97.107.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id D5D00602AD48;
	Mon,  4 Jun 2007 01:13:40 +0300 (EEST)
User-Agent: KMail/1.9.6 (enterprise 0.20070508.662491)
In-Reply-To: <7vmyzgn14w.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49042>

--nextPart1786862.qHtQhWQD9R
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 04 June 2007 01:06:55 Junio C Hamano wrote:
> Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:
> > I can try the patch if you can send me what you propose.
>
> Does the recent one from Jakub work for you?

It works fine here.

Regards,
ismail

=2D-=20
Perfect is the enemy of good

--nextPart1786862.qHtQhWQD9R
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iQIVAwUARmM9I0e9qviWcMsnAQIIlQ//f/6IayelZoGLlTDrJYihdcC4oIBM0OBL
AfQ3/mb53mkEKHeiJbT2Xmj0ZjXIgKfmHDxV/jQaU3dBo3s7Vq9/8DDQUPjGIYIt
Krhojng5AFqiviJXINUHfwwTkjltfH4D0udKRABhPGtK5dnmqlpaI38eEZhnO04B
ffxP5gokhhf1z2JbL1OHzMGDodcbKgQYrP/lMoMeYRmsCaII5R7iiDggE1nsmmGt
SwCsydHsty4emMJCYmCXTCOz6qIJuTzLsKgs6yivhhJjHsJ7h5Q9oLhM32B92ASr
vsONcxgYd8dq4LkYdfMkk+w+1bdTyt3tUKyksG9Ojsbdfil0Ovdlsc2l8r0rzoE4
uotGAwOzpKbKMMc9LJq9NRwrNsX+4A4eErmgayUemaVb47WihL8D+uo72m8vk7HL
QfKCW8qDTcdzamwH06v9AvPuQ+u57EvOBL/VRMQJCX5XEPN4wxBWC2nrwSeypvuR
3qTPSEuMvyo4lTYXQ4MB+io4ecZEZjD5/7rOWSfUYYh1FqVNTUotjup+hAStH4x1
ndIP5+l0x5h2ePmLF5dD0RZxFWx7KEw4aQdP9FYrN30GfzFIjU5WxMOHi8ag4C81
rVKcXqoy1XblwYXJW8Ahee1NYmsSWTJdxBtP8iQUgUMQcMsNNy64HKiBUWdeR5Rx
YWNvnO5Be9g=
=uIxF
-----END PGP SIGNATURE-----

--nextPart1786862.qHtQhWQD9R--
