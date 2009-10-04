Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 11080 invoked by uid 107); 4 Oct 2009 13:49:42 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 04 Oct 2009 09:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756843AbZJDNmJ (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Oct 2009 09:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756821AbZJDNmI
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 09:42:08 -0400
Received: from peff.net ([208.65.91.99]:59040 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756801AbZJDNmI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 09:42:08 -0400
Received: (qmail 11049 invoked by uid 107); 4 Oct 2009 13:44:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 04 Oct 2009 09:44:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Oct 2009 09:41:30 -0400
Date:	Sun, 4 Oct 2009 09:41:30 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com
Subject: Re: [PATCH] Add the utterly important 'mispel' command
Message-ID: <20091004134130.GB14209@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0910040040180.4985@pacific.mpi-cbg.de>
 <20091004065239.GA7890@coredump.intra.peff.net>
 <alpine.DEB.1.00.0910041250420.4985@pacific.mpi-cbg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0910041250420.4985@pacific.mpi-cbg.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Oct 04, 2009 at 12:52:09PM +0200, Johannes Schindelin wrote:

> Well, the command is called "mispel", not "autocorrect".  So I think you 
> misunderstood the purpose of the patch.

OK, well, then I can rail against the quality of your commit message. ;)

> Let this be a lesson, kids: don't review GitTogether patches before you 
> had a drink.

Heh.

-Peff
