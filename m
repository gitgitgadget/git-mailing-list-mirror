From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] provide better committer information to commit-tree.c
Date: Tue, 19 Apr 2005 11:20:32 +1000
Message-ID: <1113873634.3579.32.camel@localhost.localdomain>
References: <20050419001126.GB21170@kroah.com>
	 <Pine.LNX.4.58.0504181730130.15725@ppc970.osdl.org>
	 <20050419004548.GA21623@kroah.com>
	 <1113871951.3579.25.camel@localhost.localdomain>
	 <20050419011236.GA22091@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 03:17:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNhMN-0007nU-Vu
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 03:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVDSBVF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 21:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVDSBVF
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 21:21:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28385 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261252AbVDSBVB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 21:21:01 -0400
Received: from [150.203.247.9] (helo=[172.24.3.18])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DNhQ9-0000xk-0h; Tue, 19 Apr 2005 02:20:59 +0100
To: Greg KH <greg@kroah.com>
In-Reply-To: <20050419011236.GA22091@kroah.com>
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-04-18 at 18:12 -0700, Greg KH wrote:
> Ok, then why display it as one? 

Nobody ever displays it as one as far as I'm aware. That would be
something like "mailto:$COMMITTER"

> But I'll wait for Russell to wake up and start quoting the proper EU
> privacy laws that he feels causes him to be forced to obfuscate his
> email addresses in the changelog commits (as he did for the bk ones.)

He's talking about his own interpretation of the UK's Data Protection
Act, which requires you to be registered and fulfil certain other
requirements if you keep personal information about people in a
database. Email addresses have been ruled to be 'personal information'
in this context, but this _isn't_ an email address -- and there are
other get-out clauses for noncommercial situations such as this anyway,
I believe. 

Besides, he can still obscure the author information as he unfortunately
insists on doing; it's the _committer_ information which we're
discussing here -- and that's always going to be himself in this case.

-- 
dwmw2

