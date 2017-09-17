Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C797320A26
	for <e@80x24.org>; Sun, 17 Sep 2017 01:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbdIQB1W (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 21:27:22 -0400
Received: from port70.net ([81.7.13.123]:50565 "EHLO port70.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751451AbdIQB1V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 21:27:21 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Sep 2017 21:27:21 EDT
Received: by port70.net (Postfix, from userid 1002)
        id 3AEB6ABEC08C; Sun, 17 Sep 2017 03:17:32 +0200 (CEST)
Date:   Sun, 17 Sep 2017 03:17:32 +0200
From:   Szabolcs Nagy <nsz@port70.net>
To:     musl@lists.openwall.com
Cc:     "A. Wilcox" <awilfox@adelielinux.org>, Jeff King <peff@peff.net>,
        Kevin Daudt <me@ikke.info>, git@vger.kernel.org
Subject: Re: [musl] Re: Git 2.14.1: t6500: error during test on musl libc
Message-ID: <20170917011731.GD15263@port70.net>
Mail-Followup-To: musl@lists.openwall.com,
        "A. Wilcox" <awilfox@adelielinux.org>, Jeff King <peff@peff.net>,
        Kevin Daudt <me@ikke.info>, git@vger.kernel.org
References: <59BB3E40.7020804@adelielinux.org>
 <20170915063740.GB21499@alpha.vpn.ikke.info>
 <20170915113011.emko6q5utb7x4bvu@sigill.intra.peff.net>
 <59BCAF81.3090206@adelielinux.org>
 <xmqqpoaqupo5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpoaqupo5.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Junio C Hamano <gitster@pobox.com> [2017-09-17 09:36:26 +0900]:
> versions was in v1.8.5, it seems.  IOW, nobody tried to run Git with
> musl C in the past 4 years and you are the first one to notice?

git works fine on musl in practice, i use it for more than 4years now.

