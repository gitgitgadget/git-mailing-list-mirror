From: Thomas Gleixner <tglx@linutronix.de>
Subject: Full history
Date: Sun, 17 Apr 2005 01:52:56 +0200
Message-ID: <1113695576.28612.64.camel@tglx.tec.linutronix.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 00:49:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMw6V-00013P-P5
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 00:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVDPWxM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 18:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVDPWxM
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 18:53:12 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:1465
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261178AbVDPWxI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 18:53:08 -0400
Received: from mail.tec.linutronix.de (213-239-205-147.clients.your-server.de [213.239.205.147])
	by mail.tglx.de (Postfix) with ESMTP id 8CDB965C003;
	Sun, 17 Apr 2005 00:51:43 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 5C3EA28222;
	Sun, 17 Apr 2005 00:52:57 +0200 (CEST)
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I can publish the stuff on monday from a university nearby.

---

total blob objects   = 228384
total tree objects   = 172507 
total commit objects =  55877

The "empty" changesets which are noting merges are omitted at the
moment. Is it of interest to include them ??

It might also be interesting to export/merge the various
subsystem/maintainer trees including 2.4 into this archive. This would
cover the complete history 

Disk space according to # du -sh
blobs ~ 2GiB
tree and commit objects ~ 1.3GiB

I looked at the spread of the 450k+ objects over the 256 subdirectories
in my exported git repository:

total 456768
max per XX subdir = 1646
avg per XX subdir = 1784
min per XX subdir = 1936

tglx


