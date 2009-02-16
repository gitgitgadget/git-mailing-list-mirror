From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 22:15:50 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902162215200.6289@intel-tinevez-2-302>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>  <alpine.LNX.1.00.0902160322530.19665@iabervon.org>  <7veixybw7u.fsf@gitster.siamese.dyndns.org>  <loom.20090216T101457-231@post.gmane.org> 
 <20090216135812.GA20377@coredump.intra.peff.net>  <49999ED6.7010608@gmail.com>  <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>  <76718490902161048i3c19bb43h30b1cfc62dd9a61e@mail.gmail.com>  <alpine.DEB.1.00.0902162102180.6289@intel-tinevez-2-302>
 <76718490902161312j2aee999bga00d95231fa85647@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 23:04:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZBZi-0006C1-Ot
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 23:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbZBPWC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 17:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbZBPWC5
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 17:02:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:45968 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750880AbZBPWC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 17:02:56 -0500
Received: (qmail invoked by alias); 16 Feb 2009 21:15:55 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 16 Feb 2009 22:15:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/yVf5qJqHyabvyiSw9PXpaH5rWDF8CfzBQZ6p+Je
	cKglDaZG80tNpA
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <76718490902161312j2aee999bga00d95231fa85647@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110254>

Hi,

On Mon, 16 Feb 2009, Jay Soffian wrote:

> On Mon, Feb 16, 2009 at 3:02 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Mon, 16 Feb 2009, Jay Soffian wrote:
> >
> >> I think the right thing is *not to detach*, but rather when pushing 
> >> into a non-bare repo for it to go into refs/remotes.
> >
> > I do not think that is consistent.
> 
> Not consistent with what?

With pushing into bare repositories.  And worse, with the existing mode of 
operation.

Ciao,
Dscho
