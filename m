From: Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Wed, 20 Apr 2005 16:04:58 -0700
Message-ID: <20050420230457.GA23415@kroah.com>
References: <20050420205633.GC19112@pasky.ji.cz> <20050420211919.GA20129@kroah.com> <20050420215117.GJ19112@pasky.ji.cz> <Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org> <20050420222815.GM19112@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 01:01:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOOCC-0004B3-Ug
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 01:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVDTXFj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 19:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVDTXFj
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 19:05:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:38063 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261835AbVDTXFa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 19:05:30 -0400
Received: from [10.0.1.54] ([198.107.32.126])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j3KN5Ni17703;
	Wed, 20 Apr 2005 16:05:23 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DOOFf-69i-00; Wed, 20 Apr 2005 16:04:59 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050420222815.GM19112@pasky.ji.cz>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2005 at 12:28:15AM +0200, Petr Baudis wrote:
> Dear diary, on Thu, Apr 21, 2005 at 12:09:06AM CEST, I got a letter
> where Linus Torvalds <torvalds@osdl.org> told me that...
> > Yeah, yeah, it looks different from "cvs update", but dammit, wouldn't it 
> > be cool to just write "cg-<tab><tab>" and see the command choices? Or 
> > "cg-up<tab>" and get cg-update done for you..
> 
> I like this idea! :-) I guess that is in fact exactly what I have been
> looking for, and (as probably apparent from the current git-pasky
> structure) I prefer to have the scripts separated anyway.

I agree, it would solve the issue with 'cg' being overloaded, and I too
like the <tab><tab> completion idea.

thanks,

greg k-h
