From: Neeraj Mathawan <NEERAJM@YAHOO.COM>
Subject: Installing GIT Server
Date: Fri, 10 Aug 2012 11:17:06 -0400
Message-ID: <41E7B95B-70F0-4DCD-ADCE-213BCE4B2FAC@YAHOO.COM>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 10 17:23:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szr3B-0001nf-EQ
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 17:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758917Ab2HJPWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 11:22:53 -0400
Received: from n1-vm0.bullet.mail.bf1.yahoo.com ([72.30.235.156]:45508 "EHLO
	n1-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754572Ab2HJPWw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 11:22:52 -0400
X-Greylist: delayed 340 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Aug 2012 11:22:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=gcom1024; t=1344611829; bh=hZQB560ABfRVOYCtMngKHlIAiIx31toySweIk2YJAI0=; h=Received:Received:Received:X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:Received:From:Content-Type:Content-Transfer-Encoding:Subject:Date:Message-Id:To:Mime-Version:X-Mailer:Hi,:We have decided to use GIT for a huge government implementation, I am =:looking for some help with installation of GIT SERVER.=20; b=WXRHFz7u17MYXAfHtTmyedRVeaLvMQIy8O4sg1mQdIbYC8INHuawEhS9qk1Vzpmjr944H2maw2yie0EwuN4Ya1CmWpajjBX9WV16S2/v85EavP7+L7a9bpzFvisQKFnJ+SZVX61idWMebGoJYtGMD3bkp5ffM31Zz8lxpIdqOjo=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=gcom1024; d=yahoo.com;
	b=UylfHjGGoXpd/Odj2XUboPbTL5rw2nEFkUnmKtDCX7E+WLeHlIcxTffa9RPccblSIDY4tcmB7uvg5hcJ3PdZu0E/hjnGlHZLT0DdHE3jH95eJPkvXg81+468gc+jU2JV4ntZIl9vNGzrfxJ/ZN6Y8a0/XUX3XmUrwUKjYTXreCE=;
Received: from [72.30.235.65] by n1.bullet.mail.bf1.yahoo.com with NNFMP; 10 Aug 2012 15:17:09 -0000
Received: from [98.139.213.1] by t2.bullet.mail.bf1.yahoo.com with NNFMP; 10 Aug 2012 15:17:07 -0000
Received: from [127.0.0.1] by smtp101.mail.bf1.yahoo.com with NNFMP; 10 Aug 2012 15:17:07 -0000
X-Yahoo-Newman-Id: 412941.48682.bm@smtp101.mail.bf1.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: 9hD8HTcVM1kGdOzTBA.cMXSQLu6YSBXnngHRKeUgcW9wgrC
 2MEYsf_32DGfonAWNJsk_mJp6Me4dAiSRuQNxKERpqCw.0nozh7ftwoMq6Ft
 2kKbzWrZQs1J1EDThLYUHs7hOeoiKi1zWvDyffg_vAakCgtKrBGOeOZU5dXr
 AOuYWnAHNN06v_i59DsFig0SyDaZvwb_Md3AzTMqh1HgD30yo8Q0nl7t4frD
 pP7I_RkzzZshxZDE6vleFqsqO9vYpfbODZy8tMdWIjpbxllJ6gLnEjhH61wZ
 eDOGoCSwASRbBpnhjiZhxxu2uEZrlUdIKQ5c.dwoedYwVnzezzh1X0NxxtuM
 gVb_7CHfM_wB1eJaWeMEVwkbeu4lXY1w1oG_lYj9055f5xfvc_oK51D5jaCc
 xVPBH2eq9Mopv0Z.vO7imh02QTwiXW_Aid6sXJ8SWl.clqPDB.04.2AdI_29
 0Fbql
X-Yahoo-SMTP: 9h86oVqswBD1bcjl0kRC4YvPKUo-
Received: from new-host-3.home (NEERAJM@173.59.3.177 with plain)
        by smtp101.mail.bf1.yahoo.com with SMTP; 10 Aug 2012 15:17:07 +0000 UTC
X-Mailer: Apple Mail (2.1278)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203225>

Hi,
We have decided to use GIT for a huge government implementation, I am looking for some help with installation of GIT SERVER. 

Few questions:-

1. What platform to choose - UNIX, MAC or Windows? We have lot of windows 2008 installations, and if there are no trade off's we would love to use Windows 2008 server and install the GIT server compoent there.

2. Once that is done, the client machine mostly MAC OSX development machines...will they be able to connect using SSH or file share?

Can someone help me with this?

-Raj
