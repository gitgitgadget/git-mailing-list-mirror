From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Make cvs2git create tags
Date: Wed, 8 Jun 2005 02:43:16 +0200
Message-ID: <20050608004316.GA7916@pasky.ji.cz>
References: <20050601112723.GA18682@pc117b.liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven Verdoolaege <skimo@liacs.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 02:40:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfobZ-0000UG-Te
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 02:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVFHAnV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Jun 2005 20:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbVFHAnV
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jun 2005 20:43:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58318 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262053AbVFHAnS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2005 20:43:18 -0400
Received: (qmail 17966 invoked by uid 2001); 8 Jun 2005 00:43:16 -0000
To: torvalds@osdl.org
Content-Disposition: inline
In-Reply-To: <20050601112723.GA18682@pc117b.liacs.nl>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Jun 01, 2005 at 01:27:23PM CEST, I got a letter
where Sven Verdoolaege <skimo@liacs.nl> told me that...
> The current version of cvs2git doesn't propagate tags.
> Trivial patch below.
> 
> skimo
> -- 
> cvs2git: create tags
> 
> cvsps seems to put a space after the tag name, so we remove it first.

  Hi,

  this seems to have been forgotten along the way, and still appears to
be applicable to the latest git.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
