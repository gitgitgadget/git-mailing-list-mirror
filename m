From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 24 Jun 2008 17:25:57 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806241709330.9925@racer>
References: <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
 <7vwskjazql.fsf@gitster.siamese.dyndns.org> <20080621121429.GI29404@genesis.frugalware.org> <7vwskfclfs.fsf@gitster.siamese.dyndns.org> <9B8F0B10-F48D-475B-BF59-CEE94222B6E8@ai.rug.nl> <20080624160224.GA29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 18:29:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBBO9-0000W2-Tz
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 18:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbYFXQ2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 12:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbYFXQ2F
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 12:28:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:39473 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751398AbYFXQ2D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 12:28:03 -0400
Received: (qmail invoked by alias); 24 Jun 2008 16:28:00 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp025) with SMTP; 24 Jun 2008 18:28:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ppWEKr+3pDYXdQR94Q368it1KiQudOc78z7LaXm
	3BRIbwqzHXrIbM
X-X-Sender: gene099@racer
In-Reply-To: <20080624160224.GA29404@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86081>

Hi,

On Tue, 24 Jun 2008, Miklos Vajna wrote:

> On Tue, Jun 24, 2008 at 10:12:28AM +0200, Pieter de Bie <pdebie@ai.rug.nl> wrote:
> > Vienna:bin pieter$ git --version
> > git version 1.5.6.129.g274ea
> > Vienna:bin pieter$ git clone localhost:project/bonnenteller
> > Initialize bonnenteller/.git
> > Initialized empty Git repository in /opt/git/bin/bonnenteller/.git/
> > Password:
> > bash: git-upload-pack: command not found
> > fatal: The remote end hung up unexpectedly
> > 
> > I think that is what Miklos meant.
> 
> Exactly. Thanks for the good description.

AFAICT these are fixed with ed99a225(Merge branch 'jc/dashless' into 
next).

Ciao,
Dscho
