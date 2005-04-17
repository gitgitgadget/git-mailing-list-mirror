From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [2.1/5] Add merge-base
Date: Sun, 17 Apr 2005 17:25:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171722110.30848-100000@iabervon.org>
References: <20050417212116.GK1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 23:21:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNHCX-0004Wn-34
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 23:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVDQVY7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 17:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVDQVY7
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 17:24:59 -0400
Received: from iabervon.org ([66.92.72.58]:52231 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261481AbVDQVY5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 17:24:57 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNHGU-0002AL-00; Sun, 17 Apr 2005 17:25:14 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050417212116.GK1461@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, Petr Baudis wrote:

> Dear diary, on Sun, Apr 17, 2005 at 06:51:59PM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > merge-base finds one of the best common ancestors of a pair of commits. In
> > particular, it finds one of the ones which is fewest commits away from the
> > further of the heads.
> > 
> > Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
> 
> Note that during merge with Linus (probably the most complicated I've
> got so far, but still thankfully not too painful thanks to the rej
> tool) I've decided to revert your merge-base in favour of Linus'
> version. I did this mainly to make me merging Linus less awful; we
> should probably clean it up first and decide which solution to go for in
> the first place before possibly replacing it again, I think.

Sure. I'm working on the rearrangement now.

	-Daniel
*This .sig left intentionally blank*

