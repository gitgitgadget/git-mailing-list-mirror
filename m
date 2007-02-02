From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current
 branch reflog
Date: Fri, 02 Feb 2007 14:47:54 +0100
Message-ID: <45C3410A.4030407@fs.ei.tum.de>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>	 <20070201191323.GA18608@spearce.org>	 <7vmz3xoas9.fsf@assigned-by-dhcp.cox.net> <epv3r9$4f7$2@sea.gmane.org>	 <Pine.LNX.4.63.0702021140340.22628@wbgn013.biozentrum.uni-wuerzburg.de> <8c5c35580702020302g46f71fe3o24d7dc9490192cab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig186FF4321FFA9806A35736E7"
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Feb 02 14:48:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCyln-0008Fy-Ox
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 14:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423081AbXBBNsA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 08:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423026AbXBBNsA
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 08:48:00 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:50803 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423081AbXBBNr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 08:47:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 59C7128296
	for <git@vger.kernel.org>; Fri,  2 Feb 2007 14:47:58 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id njSocGOhIj7b for <git@vger.kernel.org>;
	Fri,  2 Feb 2007 14:47:58 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-203-79.dynamic.mnet-online.de [62.216.203.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id F305928293
	for <git@vger.kernel.org>; Fri,  2 Feb 2007 14:47:57 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
In-Reply-To: <8c5c35580702020302g46f71fe3o24d7dc9490192cab@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38498>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig186FF4321FFA9806A35736E7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Lars Hjemli wrote:
>  "HEAD@{yesterday}" =3D current branch, yesterday
>  "@{yesterday}"     =3D detached head (no branch), yesterday

+1 (actually not only "detached head", but "where my workdir was", includ=
ing named branches as well)

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig186FF4321FFA9806A35736E7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFw0ENr5S+dk6z85oRAoxlAJ9wCzCeZ0keuHxRaSUTKzTbh+7oZwCggLJU
N4GnhHVXyujS0tFabt8ElG0=
=Mt4a
-----END PGP SIGNATURE-----

--------------enig186FF4321FFA9806A35736E7--
