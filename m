Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA17820705
	for <e@80x24.org>; Wed,  7 Sep 2016 10:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935272AbcIGK3H (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 06:29:07 -0400
Received: from ikke.info ([178.21.113.177]:59796 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757227AbcIGK2V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 06:28:21 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id CA67D4400B9; Wed,  7 Sep 2016 12:28:18 +0200 (CEST)
Date:   Wed, 7 Sep 2016 12:28:18 +0200
From:   Kevin Daudt <me@ikke.info>
To:     KES <kes-kes@yandex.ru>
Cc:     git <git@vger.kernel.org>
Subject: Re: Why patch is not showed at log?
Message-ID: <20160907102818.GB28305@ikke.info>
References: <46301473235989@web8j.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46301473235989@web8j.yandex.ru>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2016 at 11:13:09AM +0300, KES wrote:
> 
> Why I do not see changes at log when 'new line' was added at the end of file?

I'm not sure what you exactly mean, but do you want to see the actual
change the patch introduces in the log output? In that case, you can use
git log --patch to include the diff.

If not, could you please explain what you mean?

Kevin
