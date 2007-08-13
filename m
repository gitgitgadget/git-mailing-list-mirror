From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Integrating the kernel tree and lkml
Date: Mon, 13 Aug 2007 12:04:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708131204220.25989@racer.site>
References: <9e4733910708121731h1245eab3h9e331de8285daf8a@mail.gmail.com>
 <46BFBD18.50007@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 13:06:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKXkP-0001dh-9P
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 13:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S943928AbXHMLF6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 07:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S942532AbXHMLF4
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 07:05:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:47568 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S943918AbXHMLFx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 07:05:53 -0400
Received: (qmail invoked by alias); 13 Aug 2007 11:05:51 -0000
Received: from R3460.r.pppool.de (EHLO noname) [89.54.52.96]
  by mail.gmx.net (mp055) with SMTP; 13 Aug 2007 13:05:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+f5hZneu2fLnDhYClQdNdzzo7jwIbmdyk/nuaWyE
	IVkJRec2Efhu3/
X-X-Sender: gene099@racer.site
In-Reply-To: <46BFBD18.50007@midwinter.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55761>

Hi,

On Mon, 13 Aug 2007, Steven Grimm wrote:

> Jon Smirl wrote:
> > You could load the lkml history into the git db along with the kernel
> > tree. Then process the mailing list history to tie discussion threads
> > to commits. As you look at commits with gitk you could also see the
> > relevant messages on lkml.
> 
> That sounds a lot like the "notes" proposal that was discussed on this 
> list a couple months back. It included a notion of "soft references" 
> which were used to tie commits to the note objects; that would 
> presumably apply to the mailing list messages as well. IIRC the 
> implementation that was proposed had some issues. Not sure what happened 
> to it in the end.

FWIW I planned to continue working on the notes post 1.5.3.

Ciao,
Dscho
