From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] git-add--interactive: manual hunk editing mode
Date: Mon, 23 Jun 2008 19:54:29 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806231952360.6440@racer>
References: <200805232221.45406.trast@student.ethz.ch> <200806120855.26847.trast@student.ethz.ch> <20080612071311.GA32491@sigill.intra.peff.net> <200806131748.44867.trast@student.ethz.ch> <20080623183840.GA28887@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 20:57:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KArEE-0001gW-Lu
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 20:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762556AbYFWS4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 14:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762553AbYFWS4a
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 14:56:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:56921 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762539AbYFWS4a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 14:56:30 -0400
Received: (qmail invoked by alias); 23 Jun 2008 18:56:28 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp033) with SMTP; 23 Jun 2008 20:56:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/jsD8La7jjYN89NhI7pD6OeEU8WmWLAqN1D899OR
	dGWBfZh3VH41U9
X-X-Sender: gene099@racer
In-Reply-To: <20080623183840.GA28887@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85905>

Hi,

On Mon, 23 Jun 2008, Jeff King wrote:

> The big question is what is happening with the recount work. Johannes, 
> are you planning on re-submitting those patches?

Oh, so much to do.  I have 55 patches in my personal fork, on top of 
'next'.  And a few of them need resubmitting, such as the initHook work, 
and, yes, add --edit.

I am not sure when I will have time for that (particularly given that I 
got sidetracked with the OPTION_OPTIONS patch, when I should have worked 
on something completely different).

In the meantime, feel free to submit in my name.

Ciao,
Dscho
