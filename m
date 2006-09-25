From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: The GPL: No shelter for the Linux kernel?
Date: Mon, 25 Sep 2006 07:59:47 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0609250757070.18552@yvahk01.tjqt.qr>
References: <MDEHLPKNGKAHNMBLJOLKIEJNOJAB.davids@webmaster.com>
 <Pine.LNX.4.61.0609231004330.9543@yvahk01.tjqt.qr> <Pine.LNX.4.64.0609231051570.4388@g5.osdl.org>
 <20060923181406.GC11916@pasky.or.cz> <Pine.LNX.4.61.0609240952240.28459@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0609240923331.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, David Schwartz <davids@webmaster.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 25 08:02:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRjYH-0004Z9-3a
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 08:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWIYGCi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 02:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWIYGCi
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 02:02:38 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:31632 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932202AbWIYGCh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Sep 2006 02:02:37 -0400
Received: from linux01.gwdg.de ([134.76.13.21])
	by mailer.gwdg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <jengelh@linux01.gwdg.de>)
	id 1GRjXn-0000Kc-Kn; Mon, 25 Sep 2006 08:02:20 +0200
Received: from linux01.gwdg.de (localhost [127.0.0.1])
	by linux01.gwdg.de (8.13.3/8.13.3/SuSE Linux 0.7) with ESMTP id k8P5xmlU018703;
	Mon, 25 Sep 2006 07:59:50 +0200
Received: from localhost (jengelh@localhost)
	by linux01.gwdg.de (8.13.3/8.13.3/Submit) with ESMTP id k8P5xlxK018697;
	Mon, 25 Sep 2006 07:59:47 +0200
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609240923331.4388@g5.osdl.org>
X-Spam-Level: /
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
X-Virus-Scanned: (clean) by exiscan+sophie
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27728>

>> Would every file that does not contain an explicit license (this 
>> excludes MODULE_LICENSE) falls under COPYING?
>
>[...]
>If a file doesn't have a license mentioned, it doesn't mean that it's 
>"free for all" or not copyrighted, it just means that you need to find out 
>what the license is some other way (and if you can't find out, you 
>shouldn't be copying that file ;)
>
>Of course, for clarity, a lot of projects end up adding at least a minimal 
>copyright header license everywhere, just to cover their *sses. It's not 
>required, but maybe it avoids some confusion, especially if that file is 
>later copied into some other project with other basic rules (but if you 
>do that, you really _should_ have added the information at that point!).
>[...]

Though I strongly agree with you, some GNU folks (such as 
savannah.nongnu.org) seem to explicitly require it, even for files 
that do not make up a single program (i.e. like coreutils/ls.c).



Jan Engelhardt
-- 
