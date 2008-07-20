From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Suggestion: doc restructuring
Date: Sun, 20 Jul 2008 13:02:01 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807201257400.3305@eeepc-johanness>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <48806D03.30603@fastmail.fm> <alpine.DEB.1.00.0807190314010.3064@eeepc-johanness> <7vk5fhc6qo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 13:02:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKWgA-0004ca-S5
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 13:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019AbYGTLBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 07:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756024AbYGTLBO
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 07:01:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:49645 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754942AbYGTLBM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 07:01:12 -0400
Received: (qmail invoked by alias); 20 Jul 2008 11:01:10 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp066) with SMTP; 20 Jul 2008 13:01:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+gGd4kzd+gXVF0egc6dkTXOMSxgaZe5xb4dtkMNV
	HIFrw3KH2uoeoS
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vk5fhc6qo.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89183>

Hi,

On Sun, 20 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > So what I really would like is this: leave the plumbing pages as they 
> > are, but enhance those pages that users (especially new ones) are 
> > likely to see most often.
> 
> Regarding the original "do we want to ever teach plumbing to new users?" 
> issue, I suspect that, with sufficient enhancement to Porcelain, we 
> might be able to reach a point where end users can work without ever 
> touching a single plumbing command at all.

I just went back to the thread I mentioned earlier, 
http://thread.gmane.org/gmane.comp.version-control.git/59935/focus=62021
and I did not find where you need plumbing.

> Perhaps move the plumbing documentation to section 3; just like Perl has 
> DBI.3pm and friends there, /usr/share/man/man3/git-cat-file.3git will 
> describe what scripts can do with the command.

But of course!  I was wondering where to put it, but understanding 
plumbing as a sort of library for shell scripts makes sense absolutely!

Ciao,
Dscho
