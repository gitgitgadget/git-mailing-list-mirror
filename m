From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: .gitconfig permissions
Date: Fri, 30 Jan 2009 20:41:44 +0300
Message-ID: <200901302042.05856.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3498983.PRzTWCPeq2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 19:02:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSxhC-0008Iu-Hh
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 19:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbZA3SBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 13:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbZA3SBA
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 13:01:00 -0500
Received: from mx28.mail.ru ([194.67.23.67]:20429 "EHLO mx28.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772AbZA3SA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 13:00:59 -0500
Received: from mx30.mail.ru (mx30.mail.ru [194.67.23.238])
	by mx28.mail.ru (mPOP.Fallback_MX) with ESMTP id 343B9776014
	for <git@vger.kernel.org>; Fri, 30 Jan 2009 20:42:52 +0300 (MSK)
Received: from [91.77.237.43] (port=58823 helo=cooker.localnet)
	by mx30.mail.ru with asmtp 
	id 1LSxNk-000G6K-00
	for git@vger.kernel.org; Fri, 30 Jan 2009 20:42:20 +0300
User-Agent: KMail/1.11.0 (Linux/2.6.29-rc3-1avb; KDE/4.2.0; i686; ; )
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107859>

--nextPart3498983.PRzTWCPeq2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I was setting StGIT options to send mail; I need SMTP authentication so=20
I'd like to set password to avoid typing it every time. After setting=20
options I checked and ~/.gitconfig was created with 664 permissions.=20
Given it may contain sensitive options, would not 600 default be better?

Thank you!

=2Dandrey

--nextPart3498983.PRzTWCPeq2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmDO98ACgkQR6LMutpd94xFIACgqpwkaccUd1FjsdmL6Cvv+maB
xmQAn0umI+T6u//GE801ncSEVx7pUqSS
=938d
-----END PGP SIGNATURE-----

--nextPart3498983.PRzTWCPeq2--
