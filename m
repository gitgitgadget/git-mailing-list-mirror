From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Add help details to git help command. (This time with Perl)
Date: Tue, 19 Apr 2005 19:50:51 +0200
Message-ID: <20050419175051.GK12757@pasky.ji.cz>
References: <200504172242.26326.elenstev@mesatop.com> <20050418102412.GJ1461@pasky.ji.cz> <42654153.8080307@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Greaves <david@dgreaves.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 19:48:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNwog-0007sl-C5
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 19:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVDSRvH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 13:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVDSRvH
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 13:51:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10691 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261473AbVDSRux (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 13:50:53 -0400
Received: (qmail 4594 invoked by uid 2001); 19 Apr 2005 17:50:51 -0000
To: Steven Cole <elenstev@mesatop.com>
Content-Disposition: inline
In-Reply-To: <42654153.8080307@mesatop.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 07:35:15PM CEST, I got a letter
where Steven Cole <elenstev@mesatop.com> told me that...
> Example:
..snip a perfect-looking example..
> ---------
> Speaking of 'git diff', I ran that before applying the following patch,
> and got a diff starting thusly:
> 
>  --- /dev/null
>  +++ b/gitmerge-file.sh
> 
> I had earlier done a 'git pull pasky', which was 'Up to date'.

Check/prune your add/rm-queue.

> So, the following patch is a conventional diff.
> 
> If the Perl filename or code  is too hideous, you're more than
> welcome to change it.

I'd actually prefer to just throw the whole help command handling
to githelp.pl. I dislike helper scripts if I can avoid them. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
