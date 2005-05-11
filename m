From: Petr Baudis <pasky@ucw.cz>
Subject: Re: gitweb wishlist
Date: Wed, 11 May 2005 04:04:02 +0200
Message-ID: <20050511020401.GM26384@pasky.ji.cz>
References: <20050511012626.GL26384@pasky.ji.cz> <20050511.104907.57995840.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kay.sievers@vrfy.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 03:58:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVgUC-0000ky-Tq
	for gcvg-git@gmane.org; Wed, 11 May 2005 03:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVEKCEP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 22:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVEKCEP
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 22:04:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39340 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261879AbVEKCEL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 22:04:11 -0400
Received: (qmail 11290 invoked by uid 2001); 11 May 2005 02:04:02 -0000
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Content-Disposition: inline
In-Reply-To: <20050511.104907.57995840.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, May 11, 2005 at 03:49:07AM CEST, I got a letter
where "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org> told me that...
> In article <20050511012626.GL26384@pasky.ji.cz> (at Wed, 11 May 2005 03:26:26 +0200), Petr Baudis <pasky@ucw.cz> says:
> 
> >   E.g. I would like to have something like
> > 
> > 	http://www.kernel.org/git/gitweb.cgi?p=cogito%2Fcogito.git;n=contrib/ciabot.pl
>                                                      ~~~ why not /?

This was a simple cut'n'paste. I don't care either way personally, but I
think it's better to be conservative when generating links and escape
this. OTOH it should obviously also accept a URL containing a slash
instead.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
