From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-init find error message on empty project directory
Date: Sun, 24 Jul 2005 10:46:55 +0200
Message-ID: <20050724084655.GA7601@pasky.ji.cz>
References: <42D49CEF.9010909@pason.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 24 10:47:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dwc8X-0002bL-JL
	for gcvg-git@gmane.org; Sun, 24 Jul 2005 10:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVGXIq7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jul 2005 04:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVGXIq7
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jul 2005 04:46:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13071 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261938AbVGXIq6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jul 2005 04:46:58 -0400
Received: (qmail 13983 invoked by uid 2001); 24 Jul 2005 08:46:55 -0000
To: Jerry Seutter <jerry.seutter@pason.com>
Content-Disposition: inline
In-Reply-To: <42D49CEF.9010909@pason.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Jul 13, 2005 at 06:47:43AM CEST, I got a letter
where Jerry Seutter <jerry.seutter@pason.com> told me that...
> When I run cg-init on an empty directory, it displays the following output:
> 
> $ cg-init
> defaulting to local storage area
> find: *: No such file or directory
> Committing initial tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> Committed as d25f00309e336884854de8cab8ab9e819294bb83.
> 
> Is the find error message supposed to be displayed?

Nope. Thanks for the report, it has been fixed recently.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
