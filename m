Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A67C1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 06:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfJKGB4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 02:01:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:45366 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726116AbfJKGB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 02:01:56 -0400
Received: (qmail 13120 invoked by uid 109); 11 Oct 2019 06:01:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Oct 2019 06:01:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30358 invoked by uid 111); 11 Oct 2019 06:04:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2019 02:04:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Oct 2019 02:01:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Raise your hand to Ack jk/code-of-conduct if your Ack fell thru
 cracks
Message-ID: <20191011060155.GB20094@sigill.intra.peff.net>
References: <xmqq36g5444k.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910082111220.46@tvgsbejvaqbjf.bet>
 <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
 <xmqq7e5bj3pb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7e5bj3pb.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 01:39:28PM +0900, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > ... but I'd still wait for a few
> > days for people who expressed their Acks but your scan missed, or
> > those who wanted to give their Acks but forgot to do so, to raise
> > their hands on this thread.
> 
> Now, two days and four hours have passed, so I'll merge the result
> to 'next' (and thusly this poll is now closed).
> 
> Thanks, all.

One final bit we might want to consider: we've heard positively from all
of the people on the project committee whose names are on the document
except Ævar. He's been rather quiet lately overall, so it may be
busyness and not silent disapproval. :) But perhaps it makes sense to
get an ack there, too (+cc).

-Peff
