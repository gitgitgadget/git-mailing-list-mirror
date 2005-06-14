From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: hgweb and gitweb: Commit times displayed incorrectly
Date: Tue, 14 Jun 2005 17:44:38 +0200
Message-ID: <42AEFB66.80902@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jun 14 17:42:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiDXY-0006qR-9M
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 17:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVFNPpZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 11:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVFNPpZ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 11:45:25 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:42922 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S261167AbVFNPo4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2005 11:44:56 -0400
Received: (qmail 1901 invoked from network); 14 Jun 2005 15:44:52 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.161.223])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <mercurial@selenic.com>; 14 Jun 2005 15:44:52 -0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by zen.uplink (Postfix) with ESMTP id B280C5F7CE9;
	Tue, 14 Jun 2005 17:44:38 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050425)
X-Accept-Language: en-us, en
To: mercurial@selenic.com, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Who is wrong there, especially with hours count?
Here it's 17:43 +0200

hgweb:
*16 hours ago: * 	*[PATCH] Typo in fbdev sysfs support, virtual_size *
changeset 30069:  	e888fb306d22e08c14c3aedac3ea32f8a918c0c0
<http://www.kernel.org/hg/?cmd=changeset;node=e888fb306d22e08c14c3aedac3ea32f8a918c0c0>

parent:  	67be48281441be602419b1ceb0bd419b3be4b84b
<http://www.kernel.org/hg/?cmd=changeset;node=67be48281441be602419b1ceb0bd419b3be4b84b>

author:  	Jon Smirl <jonsmirl@gmail.com <mailto:jonsmirl@gmail.com>>
date:  	Mon Jun 13 22:52:36 2005
files
<http://www.kernel.org/hg/?cmd=manifest;manifest=c775357b0cce7d4f6835a5e1755a7c00c8a6516c;path=/>: 
	drivers/video/fbsysfs.c
<http://www.kernel.org/hg/?cmd=filediff;node=e888fb306d22e08c14c3aedac3ea32f8a918c0c0;file=drivers/video/fbsysfs.c>



gitweb:
/11 hours ago/ 	/Jon Smirl/ 	*[PATCH] Typo in fbdev sysfs support,
virtual_size*
<http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e2c16499515aa044676a14b97a1b8a35f879152a>



author 	Jon Smirl <jonsmirl@gmail.com <mailto:jonsmirl@gmail.com>>

	Mon, 13 Jun 2005 22:52:36 +0000 (15:52 -0700)
committer 	Linus Torvalds <torvalds@ppc970.osdl.org
<mailto:torvalds@ppc970.osdl.org>>

	Tue, 14 Jun 2005 03:58:58 +0000 (20:58 -0700)
commit 	e2c16499515aa044676a14b97a1b8a35f879152a


My clone:
commit e2c16499515aa044676a14b97a1b8a35f879152a
tree 87addb997369837e8cdad63c212876d161691ad2
parent 6df3cecbb95345981718b38d357c50bc3425420a
author Jon Smirl <jonsmirl@gmail.com> Mon, 13 Jun 2005 15:52:36 -0700
committer Linus Torvalds <torvalds@ppc970.osdl.org> Mon, 13 Jun 2005
20:58:58 -0700

    [PATCH] Typo in fbdev sysfs support, virtual_size

