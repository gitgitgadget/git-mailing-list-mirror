From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 18:45:19 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806271844230.9925@racer>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>  <alpine.DEB.1.00.0806271408290.9925@racer> <9af502e50806271014l661dcfc9o4f61ee2b54677bd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Robert Anderson <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 19:48:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCI3Z-0003OC-VE
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 19:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762152AbYF0RrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 13:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762148AbYF0RrT
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 13:47:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:49473 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762062AbYF0RrS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 13:47:18 -0400
Received: (qmail invoked by alias); 27 Jun 2008 17:47:17 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp027) with SMTP; 27 Jun 2008 19:47:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183c048iFs3+1Bmglv69+rkDEU86d1miY8EIhQMSh
	ugeFqZbGvCuTdc
X-X-Sender: gene099@racer
In-Reply-To: <9af502e50806271014l661dcfc9o4f61ee2b54677bd6@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86610>

Hi,

On Fri, 27 Jun 2008, Robert Anderson wrote:

> On Fri, Jun 27, 2008 at 6:33 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Thu, 26 Jun 2008, Robert Anderson wrote:
> >
> >> Seems to me the concept of the "index" is a half-baked version of 
> >> what I really want, which is the ability to factor a working tree's 
> >> changes into its constituent parts in preparation for committing 
> >> them.
> >
> > Half-baked is probably too strong a word.
> 
> It is too subtle.  That the index state - which becomes the next 
> committed state - is not available for building or testing before 
> committing is a deep flaw.
> 
> > Now, this is not necessarily what everybody wants, which is why many 
> > people are fine with the index.
> 
> But it is something they should want, and should have, if they care
> about the quality of their commits.

This is too narrow-minded a view for me.

No longer interested,
Dscho
