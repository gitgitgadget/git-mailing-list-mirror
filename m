From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: StGIT: defaults for authname, authemail
Date: Tue, 24 Jan 2006 22:13:36 +0300
Message-ID: <200601242213.36996.arvidjaar@mail.ru>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 24 20:13:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1Tbq-0003Du-Jf
	for gcvg-git@gmane.org; Tue, 24 Jan 2006 20:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbWAXTNk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jan 2006 14:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030491AbWAXTNk
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jan 2006 14:13:40 -0500
Received: from mx3.mail.ru ([194.67.23.149]:14641 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S1030385AbWAXTNj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jan 2006 14:13:39 -0500
Received: from [85.141.134.165] (port=38483 helo=cooker.home.net)
	by mx3.mail.ru with asmtp 
	id 1F1Tbm-000KtD-00
	for git@vger.kernel.org; Tue, 24 Jan 2006 22:13:38 +0300
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15105>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Would be nice if StGIT honored GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL if they are 
set and took them as default. Would be more plug'n'play, I was rather 
surprised why stg export gave me From: <>.

I have zero python knowledge to make a patch, sorry.

regards

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD1nxgR6LMutpd94wRAkQ5AJ0ZU3bc1mCu7Cx3XsNYoAleZU9E0wCfXyVF
VM310OOCMkiXEe0HWsE1CtI=
=tfhC
-----END PGP SIGNATURE-----
