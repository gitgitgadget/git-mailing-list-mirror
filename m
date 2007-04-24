From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git todo-list ?
Date: Tue, 24 Apr 2007 20:29:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704242028350.6954@racer.site>
References: <f36b08ee0704231544r53d1bfbej7ddee0c66d894f3c@mail.gmail.com>
 <7vlkgid7x4.fsf@assigned-by-dhcp.cox.net> <7vslaqbnhq.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0704241700470.6954@racer.site> <Pine.LNX.4.64.0704241312210.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Yakov Lerner <iler.ml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 20:29:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgPlx-0002Ji-Eo
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 20:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422997AbXDXS3t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 14:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422998AbXDXS3t
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 14:29:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:38720 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422997AbXDXS3s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 14:29:48 -0400
Received: (qmail invoked by alias); 24 Apr 2007 18:29:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 24 Apr 2007 20:29:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+xEQx/diWxLcS7qHtXF7EbxWJx+35puyutYxpVRn
	TefeGhdaslfe+X
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0704241312210.28708@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45484>

Hi,

On Tue, 24 Apr 2007, Daniel Barkalow wrote:

> On Tue, 24 Apr 2007, Johannes Schindelin wrote:
> 
> > Hi,
> > 
> > On Mon, 23 Apr 2007, Junio C Hamano wrote:
> > 
> > > As with any "tracking" list, wanting to have one and starting is the 
> > > easy part.  Unless kept up to date, such a list becomes quickly useless, 
> > > or even worse than not having one, leading to wasted wild goose chase if 
> > > people look at it without knowing how stale it is.
> > 
> > I used to issue `git log -p todo -- TODO` quite a lot; thank you!
> > 
> > And I miss kernel and git cousins, too...
> 
> Why not have the TODO list in the source branches, listing features that 
> ought to be in that version but aren't? That way, people can submit 
> feature requests as patches that add to the todo list (and the requested 
> feature can be discussed in response), and patches that implement 
> features can simultaneously remove them from the todo list. Anyone 
> considering working on adding desired features would need an up-to-date 
> repository anyway.

Like Junio said, it is not starting it, but maintaining. (BTW Andy, I am 
still waiting for that list...)

Judging from my own failings in updating the documentation when doing 
patches, I have no doubt I would miss out on the TODO, too.

Ciao,
Dscho
