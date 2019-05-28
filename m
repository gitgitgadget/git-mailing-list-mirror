Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64D731F462
	for <e@80x24.org>; Tue, 28 May 2019 20:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfE1U0V (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 16:26:21 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:17210 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfE1U0V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 16:26:21 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45D52y2BdYz5tlB;
        Tue, 28 May 2019 22:26:17 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id CAB39208D;
        Tue, 28 May 2019 22:26:16 +0200 (CEST)
Subject: Re: [PATCH v5] userdiff: add Octave
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Boxuan Li <liboxuan@connect.hku.hk>, git@vger.kernel.org,
        avarab@gmail.com, philipoakley@iee.org
References: <CALM0=-mTLakSBW67vqHNX84p=uw990QDbpeUfh1HKq9N0CiiLA@mail.gmail.com>
 <20190518034623.87702-1-liboxuan@connect.hku.hk>
 <3b7a22e8-0310-3738-0476-b6d73f187331@kdbg.org>
 <xmqqpno24jtf.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1c31f3fc-9283-91ef-7c96-6eed2f010491@kdbg.org>
Date:   Tue, 28 May 2019 22:26:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqpno24jtf.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.05.19 um 18:37 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Junio will very likely appreciate if you resend with these fixes applied.
> 
> Heh, thanks, for spotting, but this round has already been in 'next'
> so any updates should be done incrementally X-<.
> 

I don't terribly mind the small grammatic weakness and the style
violation. No further action required from my point of view.

-- Hannes
