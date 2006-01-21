From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: git pull and remote tags
Date: Sat, 21 Jan 2006 11:19:08 +0300
Message-ID: <200601211119.09268.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jan 21 09:19:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0Dxu-00074e-EM
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 09:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWAUITO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 03:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWAUITO
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 03:19:14 -0500
Received: from mx2.mail.ru ([194.67.23.122]:32615 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1750754AbWAUITO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 03:19:14 -0500
Received: from [85.141.135.139] (port=54445 helo=cooker.home.net)
	by mx2.mail.ru with asmtp 
	id 1F0Dxo-0007lE-00
	for git@vger.kernel.org; Sat, 21 Jan 2006 11:19:12 +0300
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14989>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I initialized repository (it was udev by the way) using git clone when it was 
on release 080. Now after 081 was out I did "git pull" and it did pulled 
changes but I do not see tag 081. What is the proper way to sync remote 
repository with local copy while retaining all refs?

TIA

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD0e59R6LMutpd94wRAl+AAJ9KeMouJnpJi5eAk1lF9kbY58+ImQCfaWtF
AGAs+9VdGY0vSyUZWd3DeDo=
=w8zY
-----END PGP SIGNATURE-----
