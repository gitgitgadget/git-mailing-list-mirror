From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git and announcing v1.4.1-rc1
Date: Fri, 23 Jun 2006 07:59:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606230756050.6483@g5.osdl.org>
References: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606221301500.5498@g5.osdl.org>
 <Pine.LNX.4.63.0606231305000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 23 17:00:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftn8P-0003mM-Ob
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 16:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWFWO7o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 10:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWFWO7o
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 10:59:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61614 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750852AbWFWO7m (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 10:59:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5NExYUT028410
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 23 Jun 2006 07:59:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5NExXqo014458;
	Fri, 23 Jun 2006 07:59:33 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606231305000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22424>



On Fri, 23 Jun 2006, Johannes Schindelin wrote:
> > 
> >  - default to red/green for old/new lines. That's the norm, I'd think.
> 
> ... and which happens to be useless for 10% of the male population (and 
> even more if you look specifically at Asian people). But then, I just 
> pasted that part from somewhere else.

Sure. 

(Although I think it's 7% in general, and more in certain populations, 
some Western European countries included)

Which just means that we should have some way to let people set their own 
colors.

The _default_ should be the one people expect, though.

		Linus
