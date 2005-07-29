From: Timo Hirvonen <tihirvon@ee.oulu.fi>
Subject: Re: [PATCH/RFC] "Recursive Make considered harmful"
Date: Fri, 29 Jul 2005 12:12:32 +0300
Message-ID: <20050729121232.5978f5ee.tihirvon@ee.oulu.fi>
References: <20050727083910.GG19290@mythryan2.michonline.com>
 <7v4qafrk8w.fsf@assigned-by-dhcp.cox.net>
 <20050729065335.GA32263@mythryan2.michonline.com>
 <20050729073134.GA6507@mars.ravnborg.org> <20050729074614.GF24895@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: sam@ravnborg.org, ryan@michonline.com, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 11:13:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyQv5-0005yl-Cd
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 11:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVG2JMj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 05:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVG2JMj
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 05:12:39 -0400
Received: from marski.suomi.net ([212.50.131.142]:7562 "EHLO marski.suomi.net")
	by vger.kernel.org with ESMTP id S262541AbVG2JMh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 05:12:37 -0400
Received: from spam1.suomi.net (spam1.suomi.net [212.50.131.165])
 by marski.suomi.net (Sun Java System Messaging Server 6.2 (built Dec  2 2004))
 with ESMTP id <0IKD0074WTL0GI80@marski.suomi.net> for git@vger.kernel.org;
 Fri, 29 Jul 2005 12:12:37 +0300 (EEST)
Received: from garlic.home.net (addr-213-216-219-24.suomi.net [213.216.219.24])
	by spam1.suomi.net (Postfix) with SMTP id AFAB66A19; Fri,
 29 Jul 2005 12:12:32 +0300 (EEST)
In-reply-to: <20050729074614.GF24895@pasky.ji.cz>
To: Petr Baudis <pasky@suse.cz>
X-Mailer: Sylpheed version 2.0.0rc (GTK+ 2.6.8; i686-pc-linux-gnu)
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Not virus scanned: please contact OPOY for details
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.781,	required 5,
 autolearn=not spam, AWL 2.12, BAYES_00 -4.90)
X-MailScanner-From: tihirvon@ee.oulu.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 29 Jul 2005 09:46:14 +0200
Petr Baudis <pasky@suse.cz> wrote:

> FWIW, I made tiny "build system" (inspired by kconfig) for smaller
> projects I work on:

Me too! :)

http://onion.dynserv.net/~timo/index.php?page=Projects/build

It also has configuration system written in bash.

-- 
http://onion.dynserv.net/~timo/
