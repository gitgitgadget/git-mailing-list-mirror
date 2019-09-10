Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 554211F463
	for <e@80x24.org>; Tue, 10 Sep 2019 20:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfIJU04 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 16:26:56 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:4290 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfIJU04 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 16:26:56 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46Sc5B1LY4z5tlD;
        Tue, 10 Sep 2019 22:26:54 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A7C131D27;
        Tue, 10 Sep 2019 22:26:53 +0200 (CEST)
Subject: Re: [PATCH v3 0/4] git-gui: Add ability to revert selected hunks and
 lines
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190828215725.13376-1-me@yadavpratyush.com>
 <20190910192107.umew74b4mj2vyrd4@yadavpratyush.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4c60ce63-5eea-42b3-aef2-92dd04b1f34c@kdbg.org>
Date:   Tue, 10 Sep 2019 22:26:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910192107.umew74b4mj2vyrd4@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.09.19 um 21:21 schrieb Pratyush Yadav:
> If there are no further objections with the series, I will merge it in.

No objections. I use it in production.

-- Hannes
