From: Jeff King <peff@peff.net>
Subject: Re: how to force a commit date matching info from a mbox ?
Date: Fri, 23 Jan 2009 21:35:48 -0500
Message-ID: <20090124023547.GA12311@coredump.intra.peff.net>
References: <7vwscm1nic.fsf@gitster.siamese.dyndns.org> <7vljt26fp9.fsf@gitster.siamese.dyndns.org> <46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com> <20090123094529.6117@nanako3.lavabit.com> <20090123172646.6117@nanako3.lavabit.com> <7vtz7qxsxc.fsf@gitster.siamese.dyndns.org> <20090123222906.GC11328@coredump.intra.peff.net> <alpine.DEB.1.00.0901240133510.3586@pacific.mpi-cbg.de> <20090124005225.GA9864@sigill.intra.peff.net> <alpine.DEB.1.00.0901240242270.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	git list <git@vger.kernel.org>,
	Christian MICHON <christian.michon@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 03:37:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQYOf-0002P1-Hz
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 03:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811AbZAXCfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 21:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbZAXCfv
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 21:35:51 -0500
Received: from peff.net ([208.65.91.99]:35913 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996AbZAXCfv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 21:35:51 -0500
Received: (qmail 13379 invoked by uid 107); 24 Jan 2009 02:35:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 23 Jan 2009 21:35:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jan 2009 21:35:48 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901240242270.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106948>

On Sat, Jan 24, 2009 at 02:43:47AM +0100, Johannes Schindelin wrote:

> > I think that is not a new problem. Quite a few patches are "how about
> > this" patches in the middle of a thread, and leave the old subject.
> > IMHO, that is a failing of the tool in not tracking common practice, not
> > the other way around.
> 
> You know exactly what "fixing the tool" would mean.

Yes, I know. I think Pasky's tool is a clever hack, but I never expected
it to be comprehensive in its results. At the GitTogether, we discussed
some interesting ideas for tracking the mailing list and showing a more
patch-oriented view, but those would be a lot of work, and I am not
volunteering to do it right now.

What I meant by my comment was that I am not too concerned with tweaking
my workflow to help Pasky's tool.

-Peff
