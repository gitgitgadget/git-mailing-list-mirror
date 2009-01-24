From: Jeff King <peff@peff.net>
Subject: Re: how to force a commit date matching info from a mbox ?
Date: Fri, 23 Jan 2009 19:52:25 -0500
Message-ID: <20090124005225.GA9864@sigill.intra.peff.net>
References: <7vwscm1nic.fsf@gitster.siamese.dyndns.org> <7vljt26fp9.fsf@gitster.siamese.dyndns.org> <46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com> <20090123094529.6117@nanako3.lavabit.com> <20090123172646.6117@nanako3.lavabit.com> <7vtz7qxsxc.fsf@gitster.siamese.dyndns.org> <20090123222906.GC11328@coredump.intra.peff.net> <alpine.DEB.1.00.0901240133510.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	git list <git@vger.kernel.org>,
	Christian MICHON <christian.michon@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 01:54:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQWmr-0004m9-V8
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 01:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547AbZAXAwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 19:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753527AbZAXAwa
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 19:52:30 -0500
Received: from peff.net ([208.65.91.99]:41716 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752886AbZAXAw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 19:52:29 -0500
Received: (qmail 12821 invoked by uid 107); 24 Jan 2009 00:52:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 23 Jan 2009 19:52:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jan 2009 19:52:25 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901240133510.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106937>

On Sat, Jan 24, 2009 at 01:34:41AM +0100, Johannes Schindelin wrote:

> > So good to know, and I will start generating my patches differently.
> 
> Note that your patches will not be found using Pasky's "mail" link in 
> gitweb, if you do not put the commit subject into the _real_ mail subject.
> 
> Dunno if I like that.

I think that is not a new problem. Quite a few patches are "how about
this" patches in the middle of a thread, and leave the old subject.
IMHO, that is a failing of the tool in not tracking common practice, not
the other way around.

-Peff
