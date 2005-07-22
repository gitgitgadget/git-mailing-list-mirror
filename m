From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Make debian/rules executable, and correct the spelling
 of rsync in debian/control
Date: Fri, 22 Jul 2005 15:32:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507221531040.6074@g5.osdl.org>
References: <20050720011747.GK20369@mythryan2.michonline.com>
 <20050722221923.GM11916@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 00:33:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw64M-0006Rn-UI
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 00:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVGVWc0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 18:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVGVWc0
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 18:32:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5834 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261404AbVGVWcZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 18:32:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6MMW5jA003677
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Jul 2005 15:32:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6MMW1OK021243;
	Fri, 22 Jul 2005 15:32:02 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050722221923.GM11916@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 23 Jul 2005, Petr Baudis wrote:
>
> Dear diary, on Wed, Jul 20, 2005 at 03:17:47AM CEST, I got a letter
> where Ryan Anderson <ryan@michonline.com> told me that...
> > Make debian/rules executable, and correct the spelling of rsync in
> > debian/control
> 
> Any progress with applying of this one? Linus, do you want me to ack
> even trivial patches which had you in the recipient list? Or I could
> start actively maintaining git-pb again, if you wish.

I don't know what I missed when I was away for a few days - especially
since there was some noise about people correcting their own patches. So
I'd actually prefer people just re-sent the stuff to me and I can apply 
it.

		Linus
