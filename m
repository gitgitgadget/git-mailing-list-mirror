From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: how to force a commit date matching info from a mbox ?
Date: Sat, 24 Jan 2009 02:43:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901240242270.3586@pacific.mpi-cbg.de>
References: <7vwscm1nic.fsf@gitster.siamese.dyndns.org> <7vljt26fp9.fsf@gitster.siamese.dyndns.org> <46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com> <20090123094529.6117@nanako3.lavabit.com> <20090123172646.6117@nanako3.lavabit.com>
 <7vtz7qxsxc.fsf@gitster.siamese.dyndns.org> <20090123222906.GC11328@coredump.intra.peff.net> <alpine.DEB.1.00.0901240133510.3586@pacific.mpi-cbg.de> <20090124005225.GA9864@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	git list <git@vger.kernel.org>,
	Christian MICHON <christian.michon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 24 02:44:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQXZu-0008G1-N5
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 02:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680AbZAXBnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 20:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753549AbZAXBnX
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 20:43:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:41092 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753527AbZAXBnX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 20:43:23 -0500
Received: (qmail invoked by alias); 24 Jan 2009 01:43:20 -0000
Received: from pD9EB2F6A.dip0.t-ipconnect.de (EHLO noname) [217.235.47.106]
  by mail.gmx.net (mp023) with SMTP; 24 Jan 2009 02:43:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Q6/xzdwnQS6pO6m1WK53AaNO+JSHmra07/vpWT0
	rgbSZMdKTwPi1X
X-X-Sender: gene099@racer
In-Reply-To: <20090124005225.GA9864@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106942>

Hi,

On Fri, 23 Jan 2009, Jeff King wrote:

> On Sat, Jan 24, 2009 at 01:34:41AM +0100, Johannes Schindelin wrote:
> 
> > > So good to know, and I will start generating my patches differently.
> > 
> > Note that your patches will not be found using Pasky's "mail" link in 
> > gitweb, if you do not put the commit subject into the _real_ mail subject.
> > 
> > Dunno if I like that.
> 
> I think that is not a new problem. Quite a few patches are "how about
> this" patches in the middle of a thread, and leave the old subject.
> IMHO, that is a failing of the tool in not tracking common practice, not
> the other way around.

You know exactly what "fixing the tool" would mean.

Ciao,
Dscho
