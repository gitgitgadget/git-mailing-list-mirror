Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 9967 invoked by uid 107); 10 Mar 2009 11:12:44 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Tue, 10 Mar 2009 07:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162AbZCJLMh (ORCPT <rfc822;peff@peff.net>);
	Tue, 10 Mar 2009 07:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753992AbZCJLMh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 07:12:37 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:41575 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbZCJLMg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 07:12:36 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1Lgzsw-0006EP-8m; Tue, 10 Mar 2009 12:12:34 +0100
Date:	Tue, 10 Mar 2009 12:12:34 +0100
From:	Finn Arne Gangstad <finnag@pvv.org>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [RFC/PATCH] git push usability improvements and default change
Message-ID: <20090310111233.GA10036@pvv.org>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org> <alpine.DEB.1.00.0903100033400.6358@intel-tinevez-2-302> <20090310084615.GA11448@pvv.org> <alpine.DEB.1.00.0903101159530.14295@intel-tinevez-2-302>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903101159530.14295@intel-tinevez-2-302>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Mar 10, 2009 at 12:01:00PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 10 Mar 2009, Finn Arne Gangstad wrote:
> 
> > On Tue, Mar 10, 2009 at 12:35:12AM +0100, Johannes Schindelin wrote:
> > 
> > > [...]
> > > At least without a proper way to prepare existing users for the end of 
> > > the world.
> > 
> > That is pretty much what patches 4 and 5 are about - add nice warnings, 
> > but do not change behavior. 6 introduces the changed default.
> 
> Ah, so you meant that 1-5 should be committed right away, and 6 in one 
> year?

Yes, that was the intention.

- Finn Arne
