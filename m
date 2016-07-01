Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50D1D2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 15:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbcGAPCp (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 11:02:45 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40732 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912AbcGAPCo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 11:02:44 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 484FE2018A;
	Fri,  1 Jul 2016 15:02:42 +0000 (UTC)
Date:	Fri, 1 Jul 2016 15:02:42 +0000
From:	Eric Wong <e@80x24.org>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 5/9] merge-recursive: avoid returning a wholesale struct
Message-ID: <20160701150242.GA20898@dcvr.yhbt.net>
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
 <c33e9cdb1ec6cbebcc3124a62b7b9d52b92cf6c9.1467199553.git.johannes.schindelin@gmx.de>
 <xmqqr3bf3fvr.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607011542210.12947@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607011542210.12947@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> P.S.: If it is not too much of a problem, may I ask you to simply delete
> remainders of my patches when replying and not commenting on them? I just
> deleted 226 lines after verifying that you really did not respond to any
> part of it in the unhelpful Alpine client (which I still use because it
> *still* fits much better with my workflow than anything else, by a lot).
> Again, not a big deal if it would make your life more painful.

I find the over-quoting annoying, too.  Fwiw, my muttrc has:

bind pager , skip-quoted

Which allows me to hit the comma key to skip over quoted text.
Not sure if Alpine or other clients have something similar.
But I'd rather not waste the keystroke/bandwidth/storage.
