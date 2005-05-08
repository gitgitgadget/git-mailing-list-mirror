From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cg-log patches
Date: Sun, 8 May 2005 21:01:09 +0200
Message-ID: <20050508190109.GC9495@pasky.ji.cz>
References: <1742.10.10.10.24.1115573750.squirrel@linux1> <1792.10.10.10.24.1115575196.squirrel@linux1> <20050508180312.GB9495@pasky.ji.cz> <1896.10.10.10.24.1115577733.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 20:54:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUqul-0007Xf-MO
	for gcvg-git@gmane.org; Sun, 08 May 2005 20:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVEHTBO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 15:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVEHTBO
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 15:01:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52699 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261450AbVEHTBL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 15:01:11 -0400
Received: (qmail 11975 invoked by uid 2001); 8 May 2005 19:01:09 -0000
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <1896.10.10.10.24.1115577733.squirrel@linux1>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 08, 2005 at 08:42:13PM CEST, I got a letter
where Sean <seanlkml@sympatico.ca> told me that...
> On Sun, May 8, 2005 2:03 pm, Petr Baudis said:
> 
> > do you think you could also send the patches by mail, please?
> 
> Yes, attached.  But i'm hoping you'll accept them from my .git repository
> so that I can keep my own repository consistent, without conflicts from my
> own patches being pulled back in from you with different commit id's.

Different commit id's shouldn't make much difference w.r.t. conflicts.

> Is there a problem with just using cogito to manage the patches?

No problem if I decide to accept all of your patches.  But that's what I
need to find out by reviewing the patches, and when I have any comments,
I want to point them out easily in the context of the patch.

 From this viewpoint the cumulative patch you've sent is unfortunately
useless - I need it broken to the commits, in separate mails, and either
as text/plain attachments or inline, please.

> >> What do you use to publish a repository?
> >
> > What do you mean?
> 
> Well, I just copied the .git directory and everything under it up to the
> website.   But I wondered if there was a cg-push or something similar
> which would handle things a little better.  No biggy.

Nothing like that so far. It should be possible with the ssh protocol
relatively easily, and doable with rsync (although the locking is going
to be pretty be hard).

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
