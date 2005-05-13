From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH Cogito] Improve option parsing for cg-log
Date: Fri, 13 May 2005 07:41:40 +0200
Message-ID: <20050513054140.GF16464@pasky.ji.cz>
References: <1115931114.18499.66.camel@pegasus> <20050512211315.GP324@pasky.ji.cz> <1115934586.18499.70.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 13 07:34:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWSo9-00019X-DP
	for gcvg-git@gmane.org; Fri, 13 May 2005 07:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbVEMFln (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 01:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVEMFln
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 01:41:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17637 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262247AbVEMFlm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 01:41:42 -0400
Received: (qmail 23447 invoked by uid 2001); 13 May 2005 05:41:40 -0000
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1115934586.18499.70.camel@pegasus>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, May 12, 2005 at 11:49:46PM CEST, I got a letter
where Marcel Holtmann <marcel@holtmann.org> told me that...
> Hi Petr,
> 
> > > the attached patch changes the option parsing, because otherwise we are
> > > stuck to a specific order.
> > 
> > thanks, applied. However, you didn't include the -r options parsing in
> > there yet.
> 
> what do you mean by that?

The -r option still must be after all the other options.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
