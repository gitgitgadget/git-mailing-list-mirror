From: Rob Landley <rob@landley.net>
Subject: Re: Who do I report bugs in the git source web browser thing to?
Date: Thu, 23 Mar 2006 22:06:35 -0500
Message-ID: <200603232206.35242.rob@landley.net>
References: <200603231143.17762.rob@landley.net> <200603231747.32166.rob@landley.net> <BAYC1-PASMTP04E797AD25632CF422EA86AEDE0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 04:06:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMcd1-0000Ye-BW
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 04:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWCXDGQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 22:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWCXDGQ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 22:06:16 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:10690
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S964902AbWCXDGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 22:06:16 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id k2O4pMl4022139;
	Thu, 23 Mar 2006 23:51:22 -0500
To: sean <seanlkml@sympatico.ca>
User-Agent: KMail/1.8.3
In-Reply-To: <BAYC1-PASMTP04E797AD25632CF422EA86AEDE0@CEZ.ICE>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17898>

On Thursday 23 March 2006 6:23 pm, sean wrote:
> On Thu, 23 Mar 2006 17:47:31 -0500
>
> Rob Landley <rob@landley.net> wrote:
> > On Thursday 23 March 2006 12:03 pm, Linus Torvalds wrote:
> > > On Thu, 23 Mar 2006, Rob Landley wrote:
> > > Pick another file, like the Makefile, to see what real history looks
> > > like (or, better yet, go into a different directory that actually sees
> > > more real work, like kernel/, and look at the history of files there).
> >
> > I was trying to find out when symlink support went in to gen_init_cpio.c,
> > so that was the only file that interested me.  I forgot that the
> > bitkeeper history never got moved over.
>
> Rob,
>
> You might be able to find what you need in the bk history imported into
> git as "Linux kernel history" by Thomas Gleixner on kernel.org:
>
> http://kernel.org/git/?p=linux/kernel/git/tglx/history.git;a=history;h=e7e1
>73af42dbf37b1d946f9ee00219cb3b2bea6a;f=usr/gen_init_cpio.c
>
> Sean

Ooh, exactly what I was looking for.  Thanks.  (I already downloaded tarballs 
to check, but I've got the bookmark for future reference.)

Rob
-- 
Never bet against the cheap plastic solution.
