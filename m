From: Norbert Kiesel <nkiesel@tbdnetworks.com>
Subject: RSS feed conatins non UTF-8 chars
Date: Thu, 17 Nov 2005 18:52:49 -0800
Organization: TBD Networks
Message-ID: <1132282369.4806.134.camel@defiant>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nDOyxMc7b6PyME1+GZoa"
X-From: git-owner@vger.kernel.org Mon Nov 21 22:51:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeJWt-00042f-Pl
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 22:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbVKUVs3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 16:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVKUVs3
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 16:48:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51362 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751080AbVKUVs1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 16:48:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jALLmNnO012395
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 13:48:24 -0800
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jALLmNTc003006
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 13:48:23 -0800
Received: (from kees@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id jALLmN1j003005
	for git@vger.kernel.org; Mon, 21 Nov 2005 13:48:23 -0800
X-Authentication-Warning: shell0.pdx.osdl.net: kees set sender to kees@osdl.org using -f
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAI2qxLQ026258
	for <kees@mail.gateway.osdl.net>; Thu, 17 Nov 2005 18:52:59 -0800
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAI2qvnO018327
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <kees@osdl.org>; Thu, 17 Nov 2005 18:52:57 -0800
Received: from hera.kernel.org (localhost [127.0.0.1])
	by hera.kernel.org (8.13.1/8.13.1) with ESMTP id jAI2qutH015975
	for <kees@osdl.org>; Thu, 17 Nov 2005 18:52:56 -0800
Received: (from kees@localhost)
	by hera.kernel.org (8.13.1/8.13.1/Submit) id jAI2quu6015971
	for kees@osdl.org; Thu, 17 Nov 2005 18:52:56 -0800
Received: from stargazer.tbdnetworks.com ([204.13.84.100])
	by hera.kernel.org (8.13.1/8.13.1) with ESMTP id jAI2qtNa015962
	for <webmaster@kernel.org>; Thu, 17 Nov 2005 18:52:56 -0800
Received: from defiant.tbdnetworks.com
	([192.168.4.126] helo=defiant ident=nkiesel)
	by stargazer.tbdnetworks.com with esmtp (Exim 4.50)
	id 1EcwMr-0007WU-O9
	for webmaster@kernel.org; Thu, 17 Nov 2005 18:52:49 -0800
To: webmaster@kernel.org
X-Mailer: Evolution 2.2.3 
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on localhost
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
Received-SPF: none (domain of kees@hera.kernel.org does not designate permitted sender hosts)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12493>


--=-nDOyxMc7b6PyME1+GZoa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

my RSS feed reader complains that the feed is not UTF-8 although it
claims to be.

http://feedvalidator.org/check.cgi?url=3Dhttp%3A%2F%2Fwww.kernel.org%2Fgit
%2Fgitweb.cgi%3Fp%3Dlinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux-2.6.git%3Ba%
3Drss

Best,
  Norbert


--=-nDOyxMc7b6PyME1+GZoa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDfUIBOIJDAvi0wRwRAs/7AJ45/KdNH7AQClbarOu5s60B/rzJHwCgq30F
Y/y7bla/5GhIZhXA7xrTZJs=
=8eM0
-----END PGP SIGNATURE-----

--=-nDOyxMc7b6PyME1+GZoa--
