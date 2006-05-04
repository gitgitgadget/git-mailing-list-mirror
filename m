From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [ANNOUNCE] Git wiki
Date: Wed, 3 May 2006 20:53:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605032045510.6713@iabervon.org>
References: <20060503090007.GM27689@pasky.or.cz>
 <4d8e3fd30605030213r625ce87fw5cbee554f1c20fbd@mail.gmail.com>
 <Pine.LNX.4.64.0605030934220.28543@localhost.localdomain>
 <20060503142957.GA9056@spearce.org> <4458C5D7.8010501@op5.se>
 <Pine.LNX.4.64.0605030817580.4086@g5.osdl.org>
 <4d8e3fd30605030839i2bb5de8dka8a4af27755051cf@mail.gmail.com>
 <Pine.LNX.4.64.0605030856540.4086@g5.osdl.org> <e3al00$1dj$1@sea.gmane.org>
 <Pine.LNX.4.62.0605031218570.12716@qynat.qvtvafvgr.pbz> <20060503193013.GN27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Lang <dlang@digitalinsight.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 02:53:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbS5j-0006Y8-80
	for gcvg-git@gmane.org; Thu, 04 May 2006 02:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWEDAxM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 20:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWEDAxM
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 20:53:12 -0400
Received: from iabervon.org ([66.92.72.58]:6675 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750830AbWEDAxL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 20:53:11 -0400
Received: (qmail 8345 invoked by uid 1000); 3 May 2006 20:53:50 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 May 2006 20:53:50 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060503193013.GN27689@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19542>

On Wed, 3 May 2006, Petr Baudis wrote:

> Dear diary, on Wed, May 03, 2006 at 09:21:54PM CEST, I got a letter
> where David Lang <dlang@digitalinsight.com> said that...
> > On Wed, 3 May 2006, Jakub Narebski wrote:
> > 
> > >As to content, we could I think use material found at Wikipedia Git page,
> > >and on External Links in Wikipedia Git_(software) article, not repeating of
> > >course what is in official Git Documentation/
> > 
> > please go ahead and put a lot of the info that is in the GIT 
> > Documentation/ on the wiki. it's far easier to go to one site and browse 
> > around to find things then to run into issues where you have to go 
> > somewhere else (with different tools) to find the info.
> > 
> > even if you just put all the documentation files there, as-is (as text 
> > files even, no hyperlinks in them) they should still be there.
> 
> Then who will keep it in sync (BOTH ways)? That would be quite a lot of
> work, I think.
> 
> That said, having the documentation in a wiki is not a bad idea per se,
> but you need to keep things consistent and converging. And I believe
> (and hope) that killing Documentation/ directory is no option - I hate
> it when documentation of software I installed just tells me "look at
> this URI" (which documents a different version anyway, and it's all very
> useful when I'm sitting in a train with my notebook).

Clearly the solution is a wiki with a git backend and asciidoc for the 
formatting language. Then the wiki just has to pull from kernel.org 
occasionally, and Junio can pull from the wiki's repository when there are 
good changes there.

I'm actually only somewhat joking; I wrote a Python CGI for this at one 
point, and got as far as having it basically work, but then I couldn't 
come up with a way to safely use asciidoc to format an attacker's file.

	-Daniel
*This .sig left intentionally blank*
