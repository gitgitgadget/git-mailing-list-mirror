Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA7FF1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 16:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757832AbcIUQ0a (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 12:26:30 -0400
Received: from ikke.info ([178.21.113.177]:35322 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753311AbcIUQ0a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 12:26:30 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 0BEDC4400B9; Wed, 21 Sep 2016 18:26:28 +0200 (CEST)
Date:   Wed, 21 Sep 2016 18:26:28 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2016, #05; Mon, 19)
Message-ID: <20160921162628.GA27363@ikke.info>
References: <xmqqd1jzcvs5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd1jzcvs5.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 04:30:34PM -0700, Junio C Hamano wrote:
> 
> * kd/mailinfo-quoted-string (2016-09-19) 2 commits
>  - mailinfo: unescape quoted-pair in header fields
>  - t5100-mailinfo: replace common path prefix with variable

Is this good enough, or do you want me to look into the feedback from
jeff?
