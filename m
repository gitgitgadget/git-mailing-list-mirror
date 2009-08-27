From: Christian Senkowski <csenkowski@gmx.de>
Subject: [SCuMD]
Date: Thu, 27 Aug 2009 11:53:29 +0200
Message-ID: <4A965799.6050204@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9336578EFB5442092BF1ED6D"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 12:00:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgbma-0005Xo-FQ
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 12:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbZH0KAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 06:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbZH0KAB
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 06:00:01 -0400
Received: from mail.kon.de ([81.88.34.125]:52363 "EHLO mail.kon.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002AbZH0KAA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 06:00:00 -0400
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Aug 2009 06:00:00 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.kon.de (Postfix) with ESMTP id 74C3440081585
	for <git@vger.kernel.org>; Thu, 27 Aug 2009 11:53:30 +0200 (CEST)
X-Virus-Scanned: spam-virus-check at kon.de
Received: from mail.kon.de ([127.0.0.1])
	by localhost (mail.kon.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id aYZ1A3YZsfke for <git@vger.kernel.org>;
	Thu, 27 Aug 2009 11:53:29 +0200 (CEST)
Received: from christian.technik.kon (office-nat.kon.de [81.88.33.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kon.de (Postfix) with ESMTPSA id 4AAE940081583
	for <git@vger.kernel.org>; Thu, 27 Aug 2009 11:53:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Thunderbird/3.0b3
X-Enigmail-Version: 0.97a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127151>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9336578EFB5442092BF1ED6D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

I cloned SCuMD directly via git and started it but got following error:

~/scumd$ ./run.sh
Exception in thread "main" java.lang.NoClassDefFoundError:
com.asolutions.scmsshd.SCuMD
   at gnu.java.lang.MainThread.run(libgcj.so.90)
Caused by: java.lang.ClassNotFoundException:
com.asolutions.scmsshd.SCuMD not found in
gnu.gcj.runtime.SystemClassLoader{urls=3D[file:depend/lib/jgit.jar,file:d=
epend/lib/minasshd.jar,file:lib/aopalliance-1.0.jar,file:lib/bcprov-jdk15=
-140.jar,file:lib/commons-io-1.4.jar,file:lib/commons-logging-1.0.4.jar,f=
ile:./,file:lib/jline-0.9.1.jar,file:lib/jline-0.9.94.jar,file:lib/jpam-1=
=2E1.jar,file:lib/jsch-0.1.40.jar,file:lib/jzlib-1.0.7.jar,file:lib/log4j=
-1.2.13.jar,file:lib/slf4j-api-1.5.2.jar,file:lib/slf4j-log4j12-1.4.3.jar=
,file:lib/spring-beans-2.5.5.jar,file:lib/spring-context-2.5.5.jar,file:l=
ib/spring-core-2.5.5.jar],
parent=3Dgnu.gcj.runtime.ExtensionClassLoader{urls=3D[], parent=3Dnull}}
   at java.net.URLClassLoader.findClass(libgcj.so.90)
   at gnu.gcj.runtime.SystemClassLoader.findClass(libgcj.so.90)
   at java.lang.ClassLoader.loadClass(libgcj.so.90)
   at java.lang.ClassLoader.loadClass(libgcj.so.90)
   at gnu.java.lang.MainThread.run(libgcj.so.90)


Please help me out :)


Kind regards,
C. Senkowski

--=20
Christian Senkowski



--------------enig9336578EFB5442092BF1ED6D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkqWV5kACgkQ6enlpuZl7qbLkgCeJ+TwMjJUOEEJUCHV3/ZjwIRb
F5IAoIrZ9zmDWDNid6d2X9rTyarOszzV
=IO6A
-----END PGP SIGNATURE-----

--------------enig9336578EFB5442092BF1ED6D--
