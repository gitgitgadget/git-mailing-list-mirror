From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: Re: Add "clone" support to lntree
Date: Sun, 17 Apr 2005 01:44:54 +0200
Message-ID: <20050416234454.GR19099@pasky.ji.cz>
References: <20050416230000.GN19099@pasky.ji.cz> <Pine.LNX.4.21.0504161902380.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 01:41:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwur-0005PR-Sr
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 01:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVDPXpC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 19:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVDPXpC
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 19:45:02 -0400
Received: from w241.dkm.cz ([62.24.88.241]:19079 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261207AbVDPXo4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 19:44:56 -0400
Received: (qmail 16505 invoked by uid 2001); 16 Apr 2005 23:44:54 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504161902380.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 17, 2005 at 01:07:35AM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > Actually, what about if git pull outside of repository did what git
> > clone does now? I'd kinda like clone instead of fork too.
> 
> This seems like the best solution to me, too. Although that would make
> pull take a URL when making a new repository and not otherwise, which
> might be confusing. "init-remote" perhaps, or maybe just have "init" do it
> if given a URL?

Yes, init taking URL optionally sounds ideal. Thanks.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
