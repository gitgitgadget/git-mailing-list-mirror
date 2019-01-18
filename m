Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39A971F453
	for <e@80x24.org>; Fri, 18 Jan 2019 18:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbfARSiR (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 13:38:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:41336 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728457AbfARSiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 13:38:16 -0500
Received: (qmail 13651 invoked by uid 109); 18 Jan 2019 18:38:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Jan 2019 18:38:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13432 invoked by uid 111); 18 Jan 2019 18:38:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 18 Jan 2019 13:38:19 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Jan 2019 13:38:14 -0500
Date:   Fri, 18 Jan 2019 13:38:14 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, bwilliamseng@gmail.com,
        git <git@vger.kernel.org>, bwilliams.eng@gmail.com
Subject: Re: [PATCH] mailmap: update brandon williams's email address
Message-ID: <20190118183814.GA9591@sigill.intra.peff.net>
References: <20181207205621.49961-1-bwilliams.eng@gmail.com>
 <20181207214013.GA73340@google.com>
 <CAGZ79kYrgpZDqAhg8c11V_qJTCzzw4-qrVN2z_Y_OAeCbWU6dQ@mail.gmail.com>
 <20181207222225.GC73340@google.com>
 <20190118165754.GA11350@sigill.intra.peff.net>
 <xmqqa7jxltku.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7jxltku.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 10:16:33AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I just had to cc Brandon and manually look up his email address, which
> > made me wonder what ever happened to this patch. :)
> 
> d076ad13 ("Merge branch 'bw/mailmap'", 2019-01-14)

Oh, heh. False alarm: I was looking up his address after bisecting back
to a failure from last year. And my "who" alias walks from the current
HEAD. It should probably choose a known-current point like
"origin/master".

Sorry for the noise!

-Peff
