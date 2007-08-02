From: Thomas Schwinge <tschwinge@gnu.org>
Subject: [tschwinge@gnu.org: [PATCH] Support building on GNU/Hurd]
Date: Thu, 2 Aug 2007 10:56:42 +0200
Message-ID: <20070802085642.GK6234@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zROEGoKAXsG5UqGB"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 10:54:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGWRw-0005uN-FV
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 10:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889AbXHBIyU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 04:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753514AbXHBIyU
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 04:54:20 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:36748 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351AbXHBIyT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 04:54:19 -0400
Received: from tschwinge by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <tschwinge@gnu.org>)
	id 1IGWU6-000179-Na; Thu, 02 Aug 2007 04:56:42 -0400
Content-Disposition: inline
X-Homepage: http://nic-nac-project.de/~schwinge/
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54525>


--zROEGoKAXsG5UqGB
Content-Type: multipart/mixed; boundary="EEx6GiKZGZ1wKUra"
Content-Disposition: inline


--EEx6GiKZGZ1wKUra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Junio!

I sent this patch (see the attached email message) to the git mailing
list on 2007-07-28, alongside with another GNU/Hurd-related patch.  The
latter patch was included already (by you), but not this one.  Could you
please include it?

Thanks!


Regards,
 Thomas

--EEx6GiKZGZ1wKUra
Content-Type: message/rfc822
Content-Disposition: inline

Received: from monty-python.gnu.org ([199.232.76.173])
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <thomas@leibniz.schwinge.homeip.net>)
	id 1IFP8L-0006ve-0g
	for tschwinge@gnu.org; Mon, 30 Jul 2007 02:53:37 -0400
Received: from Debian-exim by monty-python.gnu.org with spam-scanned (Exim 4.60)
	(envelope-from <thomas@leibniz.schwinge.homeip.net>)
	id 1IFP6F-0007qi-64
	for tschwinge@gnu.org; Mon, 30 Jul 2007 02:51:29 -0400
X-Spam-Checker-Version: SpamAssassin 3.1.0 (2005-09-13) on monty-python
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.1.0
Received: from mail-in-15.arcor-online.net ([151.189.21.55])
	by monty-python.gnu.org with esmtps (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <thomas@leibniz.schwinge.homeip.net>)
	id 1IFP6E-0007qM-Ec
	for tschwinge@gnu.org; Mon, 30 Jul 2007 02:51:26 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-15.arcor-online.net (Postfix) with ESMTP id 59735A4395
	for <tschwinge@gnu.org>; Sat, 28 Jul 2007 18:39:43 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 4751C345BE8
	for <tschwinge@gnu.org>; Sat, 28 Jul 2007 18:39:43 +0200 (CEST)
Received: from server.schwinge.homeip.net (stgt-d9beacf6.pool.mediaWays.net [217.190.172.246])
	(Authenticated sender: tschwinge@arcor.de)
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 15D2D212F68
	for <tschwinge@gnu.org>; Sat, 28 Jul 2007 18:39:42 +0200 (CEST)
Received: (qmail 23763 invoked from network); 28 Jul 2007 16:39:38 -0000
Received: from leibniz.schwinge.homeip.net (192.168.111.120)
  by server.schwinge.homeip.net with SMTP; 28 Jul 2007 16:39:38 -0000
Received: (nullmailer pid 2040 invoked by uid 500);
	Sat, 28 Jul 2007 16:39:39 -0000
From: Thomas Schwinge <tschwinge@gnu.org>
To: git@vger.kernel.org
Cc: Thomas Schwinge <tschwinge@gnu.org>
Subject: [PATCH] Support building on GNU/Hurd
Date: Sat, 28 Jul 2007 18:39:38 +0200
Message-Id: <11856407793933-git-send-email-tschwinge@gnu.org>
X-Mailer: git-send-email 1.5.3.rc3.26.g6c58-dirty
X-Virus-Scanned: ClamAV 0.91.1/3795/Sat Jul 28 04:08:57 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
X-detected-kernel: Linux 2.6, seldom 2.4 (older, 4)
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.1

GNU/Hurd systems don't have strlcpy either.

Signed-off-by: Thomas Schwinge <tschwinge@gnu.org>
---
 Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 2fea115..8d9a01b 100644
--- a/Makefile
+++ b/Makefile
@@ -458,6 +458,10 @@ ifeq ($(uname_S),AIX)
 	NO_STRLCPY = YesPlease
 	NEEDS_LIBICONV=YesPlease
 endif
+ifeq ($(uname_S),GNU)
+	# GNU/Hurd
+	NO_STRLCPY=YesPlease
+endif
 ifeq ($(uname_S),IRIX64)
 	NO_IPV6=YesPlease
 	NO_SETENV=YesPlease
-- 
1.5.3.rc3.26.g6c58-dirty



--EEx6GiKZGZ1wKUra--

--zROEGoKAXsG5UqGB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFGsZxKgfzh735dTTURArbHAKCNY8OFfyeIF8sw63EJaJg/MYC+aACfaK8n
FSMitkdajOXGu3HQhsm8HvA=
=V3M4
-----END PGP SIGNATURE-----

--zROEGoKAXsG5UqGB--
