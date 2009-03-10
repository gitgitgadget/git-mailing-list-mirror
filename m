Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	LIST_MIRROR_RECEIVED,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: (qmail 9880 invoked by uid 107); 10 Mar 2009 11:01:20 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Tue, 10 Mar 2009 07:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223AbZCJLBJ (ORCPT <rfc822;peff@peff.net>);
	Tue, 10 Mar 2009 07:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754106AbZCJLBJ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 07:01:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:50530 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754032AbZCJLBH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 07:01:07 -0400
Received: (qmail invoked by alias); 10 Mar 2009 11:01:00 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 10 Mar 2009 12:01:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/QIl5DO6zQ/pjd0pYvTyB/SwOepmS2RDeCeqgWgO
	EpqHiRH+B6yF7i
Date:	Tue, 10 Mar 2009 12:01:00 +0100 (CET)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: schindel@intel-tinevez-2-302
To:	Finn Arne Gangstad <finnag@pvv.org>
cc:	git@vger.kernel.org
Subject: Re: [RFC/PATCH] git push usability improvements and default change
In-Reply-To: <20090310084615.GA11448@pvv.org>
Message-ID: <alpine.DEB.1.00.0903101159530.14295@intel-tinevez-2-302>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org> <alpine.DEB.1.00.0903100033400.6358@intel-tinevez-2-302> <20090310084615.GA11448@pvv.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Tue, 10 Mar 2009, Finn Arne Gangstad wrote:

> On Tue, Mar 10, 2009 at 12:35:12AM +0100, Johannes Schindelin wrote:
> 
> > On Mon, 9 Mar 2009, Finn Arne Gangstad wrote:
> > 
> > > git push default change:
> > > 
> > > git push will by default push "nothing" instead of "matching".
> > 
> > Hasn't this been shot down already?  I do not want that change.  I 
> > think it is harmful.
> > 
> > At least without a proper way to prepare existing users for the end of 
> > the world.
> 
> That is pretty much what patches 4 and 5 are about - add nice warnings, 
> but do not change behavior. 6 introduces the changed default.

Ah, so you meant that 1-5 should be committed right away, and 6 in one 
year?

Ciao,
Dscho

