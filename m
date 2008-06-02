From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 2 Jun 2008 20:25:47 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806022025030.13507@racer.site.net>
References: <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org> <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806021545340.13507@racer.site.net> <20080602154320.GK12896@spearce.org> <alpine.DEB.1.00.0806021659480.13507@racer.site.net>
 <7vej7f7lj5.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806022012510.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 21:28:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3FhH-0000xO-31
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 21:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070AbYFBT1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 15:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753050AbYFBT1F
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 15:27:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:58964 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752999AbYFBT1E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 15:27:04 -0400
Received: (qmail invoked by alias); 02 Jun 2008 19:27:00 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.2]) [141.5.10.38]
  by mail.gmx.net (mp046) with SMTP; 02 Jun 2008 21:27:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9fhY5MxK9yrH4DMNRYpjXzEslXqg/SfTRAk2v4y
	S94zT0zmihuZVH
X-X-Sender: gene099@racer.site.net
In-Reply-To: <alpine.DEB.1.00.0806022012510.13507@racer.site.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83558>

Hi,

On Mon, 2 Jun 2008, Johannes Schindelin wrote:

> On Mon, 2 Jun 2008, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > After sending the mail, I actually got an idea:
> > >
> > > 	.git/logs/attic/<timestamp>/<refname>

Just tried that, and for obvious reasons it fails the testsuite: Git is 
just too darned fast.

Ciao,
Dscho
