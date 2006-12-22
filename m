From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Fri, 22 Dec 2006 14:34:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612221432430.3671@woody.osdl.org>
References: <38b2ab8a0612210424o4ec5fcd5kb5086c52ccd76491@mail.gmail.com>
 <Pine.LNX.4.64.0612211013500.3394@woody.osdl.org> <87slf83erg.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0612212009370.3536@woody.osdl.org> <877iwjinda.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Francis Moreau <francis.moro@gmail.com>,
	Jay Cliburn <jacliburn@bellsouth.net>, git@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Fri Dec 22 23:34:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxsyS-0002QC-1g
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 23:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbWLVWel (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 17:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752686AbWLVWel
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 17:34:41 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48977 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752778AbWLVWek (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 17:34:40 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBMMYJ2J027178
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Dec 2006 14:34:20 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBMMYIOI002222;
	Fri, 22 Dec 2006 14:34:19 -0800
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <877iwjinda.wl%cworth@cworth.org>
X-Spam-Status: No, hits=-0.653 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.165 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35238>



On Fri, 22 Dec 2006, Carl Worth wrote:
> 
> I can understand the advantage of a shortcut like "git diff ..next",
> but I still don't understand why it's the comparison of HEAD and next
> that's really interesting here.

I can't understand why people complain about this.

YOU DON'T HAVE TO USE IT. 

Nobvody forces you. Really. And dammit, if I want to compare HEAD and 
next, I compare HEAD and next. You have absolutely no business saying that 
you don't understand why I'd want to do it. It's MY LIFE.

> But, really, I still don't understand exactly _what_ "diff a..b" even
> means. Can you explain it to me?

It means exactly the same as "diff a b".

It's that simple.

So now go away. Stop complaining.

		Linus
