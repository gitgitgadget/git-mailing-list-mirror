From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Replace "echo -n" with printf in shell scripts.
Date: Thu, 18 Jan 2007 01:02:58 +0100
Message-ID: <45AEB932.3060509@fs.ei.tum.de>
References: <17437.1168911089@lotus.CS.Berkeley.EDU>	<7v1wlv1yeh.fsf@assigned-by-dhcp.cox.net>	<200701171629.l0HGTCE3019292@laptop13.inf.utfsm.cl> <7vk5zlsglk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3366E94E757475772BD19C35"
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 01:24:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7L4Y-00037J-GK
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 01:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbXARAYE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 19:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbXARAYE
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 19:24:04 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:44481 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbXARAYB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 19:24:01 -0500
X-Greylist: delayed 1256 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jan 2007 19:24:01 EST
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 4512928159;
	Thu, 18 Jan 2007 01:03:02 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 03zFd8GiutTO; Thu, 18 Jan 2007 01:03:02 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-203-221.dynamic.mnet-online.de [62.216.203.221])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id B9EE228133;
	Thu, 18 Jan 2007 01:03:01 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk5zlsglk.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37049>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3366E94E757475772BD19C35
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
>>> We have done this already so it might be too late to raise this
>>> question, but does everybody have printf?
> The problematic are less common ones, ranging from (not so less
> common) OSX, Solaris to (much less common) AIX that some people
> seem to run git on (or at least compile git for).

printf(1) is part of POSIX/SUSv3, so systems *should* have it.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig3366E94E757475772BD19C35
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFrrk1r5S+dk6z85oRAmM/AKDG1JwKVZGX/S8ZjPIUJ6CvdyhERgCglZ1x
cC5oFMJxYR9Jm0sG52xiqI0=
=aELI
-----END PGP SIGNATURE-----

--------------enig3366E94E757475772BD19C35--
