From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cg-log patches
Date: Sun, 8 May 2005 21:18:31 +0200
Message-ID: <20050508191831.GD9495@pasky.ji.cz>
References: <1742.10.10.10.24.1115573750.squirrel@linux1> <1115574136.9031.147.camel@pegasus> <1856.10.10.10.24.1115576809.squirrel@linux1> <1115578807.8949.12.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>,
	GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 21:30:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUrT9-0002mH-HM
	for gcvg-git@gmane.org; Sun, 08 May 2005 21:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262968AbVEHTg2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 15:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbVEHTfS
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 15:35:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:9692 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262963AbVEHTSe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 15:18:34 -0400
Received: (qmail 13188 invoked by uid 2001); 8 May 2005 19:18:31 -0000
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1115578807.8949.12.camel@pegasus>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 08, 2005 at 09:00:07PM CEST, I got a letter
where Marcel Holtmann <marcel@holtmann.org> told me that...
> Hi Sean,
> 
> > > why don't you use diffstat for it? I think that it is more handy then
> > > the list of modified files.
> > 
> > Is a good idea, but would be a fair bit harder to generate unfortunately. 
> > Right now the blobs themselves don't have to be opened and inspected, just
> > the commit trees.   Actually, i'm not sure exactly how you'd even go about
> > generating a correct diffstat for commits that have multiple parents.
> 
> I am not a really good git expert, but maybe another option for it would
> be fine.
> 
> However there is another thing that I am missing. With Bitkeeper I was
> able to do something like "bk changes -umarcel" to list all changes done
> by the user "marcel". I like to have something similar with cg-log. Any
> ideas on how to do that?

What should it take in regard? Username portion of the email address?
The email address itself? The realname?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
