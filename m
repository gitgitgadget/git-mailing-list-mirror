From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Suggestion: doc restructuring [was: Re: Considering teaching
 plumbing to users harmful]
Date: Sat, 19 Jul 2008 03:19:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807190314010.3064@eeepc-johanness>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <48806D03.30603@fastmail.fm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Sat Jul 19 03:19:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KK16p-0005Bz-G4
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 03:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbYGSBSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 21:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753228AbYGSBSk
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 21:18:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:40123 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752326AbYGSBSj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 21:18:39 -0400
Received: (qmail invoked by alias); 19 Jul 2008 01:18:38 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp051) with SMTP; 19 Jul 2008 03:18:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19LKlJuJdhLiiIm/+Q9YHcG9s8A8wVd0cnJU8HAKI
	g8XnLdjNBFtLDZ
X-X-Sender: user@eeepc-johanness
In-Reply-To: <48806D03.30603@fastmail.fm>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89094>

Hi,

On Fri, 18 Jul 2008, Michael J Gruber wrote:

> Johannes Schindelin venit, vidit, dixit 16.07.2008 19:21:
> ...
> > 
> > Am I the only one who deems teaching plumbing to users ("I like it 
> > raw!  So I teach it the same way!") harmful?
> 
> In an attempt at making not only Dscho happier I suggest a restructuring 
> of the man pages in the following way:
> 
> In each man page, put a note which says something like: "This is part of 
> linkgit:gitplumbing[7]." and the like It should be in a prominent place, 
> such as the last line of "DESCRIPTION".

Actually, I do not particularly like that direction.

Recently, somebody taught me that it makes sense, from the psychological 
view, to stress positive points, and avoid negative terms.

For example, "do not use this" -- even if followed by "use that instead" 
-- is suboptimal.  People will be more stressed, have a shorter attention 
span, and in general recall much less, if you use negative terms.

So what I really would like is this: leave the plumbing pages as they are, 
but enhance those pages that users (especially new ones) are likely to see 
most often.

By "enhancing" I mean to illustrate the principles and commands more in 
term of a select _few_ commands.  And they should describe the options 
themselves, instead of referring to plumbing man pages.

Maybe I'll find some time this weekend to write up a bit more of my 
tutorials, which I would then post so people see what I mean should be 
taught to n00bs first.

Ciao,
Dscho
