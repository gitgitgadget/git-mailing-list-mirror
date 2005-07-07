From: Petr Baudis <pasky@suse.cz>
Subject: Re: BUG:  "rpmbuild -ta cogito-0.12.tar.gz" fails
Date: Thu, 7 Jul 2005 16:47:46 +0200
Message-ID: <20050707144746.GH19781@pasky.ji.cz>
References: <dah8i2$c8v$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 16:50:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqXgh-0001qR-U4
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 16:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVGGOs7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 10:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVGGOsj
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 10:48:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53671 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261790AbVGGOrr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 10:47:47 -0400
Received: (qmail 2486 invoked by uid 2001); 7 Jul 2005 14:47:46 -0000
To: John Ellson <ellson@research.att.com>
Content-Disposition: inline
In-Reply-To: <dah8i2$c8v$1@sea.gmane.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Jul 06, 2005 at 08:40:00PM CEST, I got a letter
where John Ellson <ellson@research.att.com> told me that...
> "rpmbuild -ta cogito-0.12.tar.gz" fails because cogito.spec.in refers to
> ".bz2" in its "Source:" line, instead of to ".gz".

(FYI, cogito.spec.in is Chris' sole teritorry in Cogito, so I'll just
put in whatever he tells me to. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
