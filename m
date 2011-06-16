From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <carlos@cmartin.tk>
Subject: Re: [PATCH] Fix typo: existant->existent
Date: Thu, 16 Jun 2011 15:19:40 +0200
Message-ID: <20110616131938.GA7751@centaur.lab.cmartin.tk>
References: <1308223595-6319-1-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Cc: git@vger.kernel.org
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 15:19:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXCUA-0002Hq-BB
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 15:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722Ab1FPNTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 09:19:45 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:56274 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304Ab1FPNTo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 09:19:44 -0400
Received: from centaur.lab.cmartin.tk (brln-4d0c05e5.pool.mediaWays.net [77.12.5.229])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id F2D86461E5;
	Thu, 16 Jun 2011 15:19:08 +0200 (CEST)
Received: (nullmailer pid 28241 invoked by uid 1000);
	Thu, 16 Jun 2011 13:19:40 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <carlos@cmartin.tk>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1308223595-6319-1-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175895>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 16, 2011 at 05:26:35PM +0600, Dmitry Ivankov wrote:
> refs.c had a error message "Trying to write ref with nonexistent object".

=46rom the patch, ITYM to say "with nonexistant object" here

Cheers,
   cmn
--=20
Carlos Mart=C3=ADn Nieto | http://cmartin.tk

"=C2=BFC=C3=B3mo voy a decir bobadas si soy mudo?" -- CACHAI

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN+gLqAAoJEHKRP1jG7ZzTZowH/iBnso/MqMCw8JzZtBIV0PLR
Jbi1z5JgnG+V/VOiYIVUdWiZZbDq4LjbpGF0LmTUZSBt/ybRCKhARddfW+RvJRW7
9aMe4/8isEaamKC2I7M+/gYylvIfk/psw916fcTIDPewlACMUlyQq1GYIKTuy4Yj
CwEZbxhltaAmO+Ohtm/w4Rql0DCEyQf9DZlvqwyFNNgSmnydU/IRxf00umRdRIrQ
dwG5XoSW2Huck+nAgWOfXS0x1rZu0QYImnMAPKFBcAq3fNp8PCdDi7nBQUQChdDw
EFpWpBdAfHzgaYFDzB1Cu27WQTD18qmaRshYO7gjjmZeNBlfQ683cdVi8Pls4jg=
=8NPd
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
