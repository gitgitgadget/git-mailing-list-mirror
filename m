From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Cogito: split Makefile targets of Cogito/git
Date: Sat, 11 Jun 2005 23:11:43 +0200
Message-ID: <20050611211142.GG3193@pasky.ji.cz>
References: <20050611195033.GA22713@vrfy.org> <20050611201933.GC22991@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 23:07:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhDCG-0000ii-Vs
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 23:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVFKVLq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 17:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVFKVLq
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 17:11:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:14256 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261682AbVFKVLo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jun 2005 17:11:44 -0400
Received: (qmail 12374 invoked by uid 2001); 11 Jun 2005 21:11:43 -0000
To: Kay Sievers <kay.sievers@vrfy.org>
Content-Disposition: inline
In-Reply-To: <20050611201933.GC22991@vrfy.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jun 11, 2005 at 10:19:33PM CEST, I got a letter
where Kay Sievers <kay.sievers@vrfy.org> told me that...
> On Sat, Jun 11, 2005 at 09:50:33PM +0200, Kay Sievers wrote:
> > This splits the targets of Cogito/git to be able to call it
> > independently. This way we can easily make Cogito a separate
> > package, which just requires git.
> 
> > +.PHONY: all it cogito
> 
> "all it cogito" sounds funny, but is obviously wrong. :)
> New patch attached.

Could you please sign off the patch?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
