From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git todo-list ?
Date: Tue, 24 Apr 2007 13:21:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704241312210.28708@iabervon.org>
References: <f36b08ee0704231544r53d1bfbej7ddee0c66d894f3c@mail.gmail.com>
 <7vlkgid7x4.fsf@assigned-by-dhcp.cox.net> <7vslaqbnhq.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0704241700470.6954@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Yakov Lerner <iler.ml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 24 19:21:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgOhg-0006aZ-My
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 19:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422776AbXDXRVU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 13:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422772AbXDXRVU
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 13:21:20 -0400
Received: from iabervon.org ([66.92.72.58]:1950 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422777AbXDXRVT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 13:21:19 -0400
Received: (qmail 25558 invoked by uid 1000); 24 Apr 2007 17:21:17 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Apr 2007 17:21:17 -0000
In-Reply-To: <Pine.LNX.4.64.0704241700470.6954@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45473>

On Tue, 24 Apr 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 23 Apr 2007, Junio C Hamano wrote:
> 
> > As with any "tracking" list, wanting to have one and starting is the 
> > easy part.  Unless kept up to date, such a list becomes quickly useless, 
> > or even worse than not having one, leading to wasted wild goose chase if 
> > people look at it without knowing how stale it is.
> 
> I used to issue `git log -p todo -- TODO` quite a lot; thank you!
> 
> And I miss kernel and git cousins, too...

Why not have the TODO list in the source branches, listing features that 
ought to be in that version but aren't? That way, people can submit 
feature requests as patches that add to the todo list (and the requested 
feature can be discussed in response), and patches that implement features 
can simultaneously remove them from the todo list. Anyone considering 
working on adding desired features would need an up-to-date repository 
anyway.

	-Daniel
*This .sig left intentionally blank*
