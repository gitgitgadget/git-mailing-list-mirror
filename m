Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BB091F461
	for <e@80x24.org>; Sat, 24 Aug 2019 08:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfHXIJW (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 04:09:22 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:16620 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfHXIJW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 04:09:22 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 46FrX01xrGz5tlB;
        Sat, 24 Aug 2019 10:09:20 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 4A33F2B7;
        Sat, 24 Aug 2019 10:09:19 +0200 (CEST)
Subject: Re: [PATCH v2 0/4] git-gui: Add ability to revert selected hunks and
 lines
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     David Aguilar <davvid@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190822220107.4153-1-me@yadavpratyush.com>
 <20190823234339.GA17088@gmail.com>
 <CAKPyHN1gA4zPL7=WYQotKmQf=hZR+gr1wH3t5GuMw9thiMTsKg@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <36714b39-dd57-a9a2-dd92-9caf7bed9039@kdbg.org>
Date:   Sat, 24 Aug 2019 10:09:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKPyHN1gA4zPL7=WYQotKmQf=hZR+gr1wH3t5GuMw9thiMTsKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.08.19 um 08:57 schrieb Bert Wesarg:
> On Sat, Aug 24, 2019 at 1:43 AM David Aguilar <davvid@gmail.com> wrote:
>> On the other hand, if I had to actually move my hand over to a mouse or
>> trackpad and actually "click" on something then I would be super
>> annoyed.  That would be simply horrible with RSI in mind.
>>
> 
> I take this as a point for*not* having a confirmation dialog when
> doing the action per mouse. Which matches exactly my original
> implementation.

I totally agree.

-- Hannes
