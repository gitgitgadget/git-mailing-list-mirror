From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: as promised, docs: git for the confused
Date: Mon, 12 Dec 2005 19:53:19 +0200
Message-ID: <20051212195319.11d41269.tihirvon@gmail.com>
References: <20051209215414.14072.qmail@science.horizon.com>
 <7vmzj9zwfu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0512120827440.15597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: junkio@cox.net, linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 18:55:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Elrrp-0006mQ-CU
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 18:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVLLRxd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 12:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVLLRxd
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 12:53:33 -0500
Received: from marski.suomi.net ([212.50.131.142]:10700 "EHLO marski.suomi.net")
	by vger.kernel.org with ESMTP id S932069AbVLLRxd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2005 12:53:33 -0500
Received: from prolisok.suomi.net (prolisok.suomi.net [212.50.140.226])
 by marski.suomi.net (Sun Java System Messaging Server 6.2 (built Dec  2 2004))
 with ESMTP id <0IRE00FF8CCZY130@marski.suomi.net> for git@vger.kernel.org;
 Mon, 12 Dec 2005 19:53:24 +0200 (EET)
Received: from spam2.suomi.net (spam2.suomi.net [212.50.131.166])
 by mailstore.suomi.net
 (Sun Java System Messaging Server 6.2-3.04 (built Jul 15 2005))
 with ESMTP id <0IRE007LPCL04U50@mailstore.suomi.net>; Mon,
 12 Dec 2005 19:58:12 +0200 (EET)
Received: from garlic.home.net (addr-82-128-203-211.suomi.net [82.128.203.211])
	by spam2.suomi.net (Postfix) with SMTP id AD4C811B560; Mon,
 12 Dec 2005 19:53:19 +0200 (EET)
In-reply-to: <Pine.LNX.4.64.0512120827440.15597@g5.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.8; i686-pc-linux-gnu)
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.286,	required 5,
 autolearn=not spam, AWL 0.31, BAYES_00 -2.60)
X-OPOY-MailScanner-From: tihirvon@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13530>

On Mon, 12 Dec 2005 08:34:12 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> Or maybe it's just me. But I know _I_ understand things better by seeing 
> the "context" that they are used in. Then I go to man-pages later on, if I 
> want to know the details.

Me too.  BTW, new users very likely read tutorial.txt first.  But it is
way too low level (git-cat-file, git-write-tree...).  Maybe those low
level commands should be described in technical/ instead?  The tutorial
would be logical place for examples.

-- 
http://onion.dynserv.net/~timo/
