Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 764041F463
	for <e@80x24.org>; Mon, 30 Sep 2019 07:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbfI3H3U (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 03:29:20 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.93]:24682 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbfI3H3T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 03:29:19 -0400
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.2)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iEq4L-0002ao-7S; Mon, 30 Sep 2019 09:26:05 +0200
Subject: Re: [PATCH v3 2/2] t0028: add more tests
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.347.v2.git.gitgitgadget@gmail.com>
 <pull.347.v3.git.gitgitgadget@gmail.com>
 <e4410274e61f17d6f162a9218138cd2e56de7b7b.1569321628.git.gitgitgadget@gmail.com>
 <xmqqv9tdjacr.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <295b07ab-504a-30d6-7f40-fa7c37340638@syntevo.com>
Date:   Mon, 30 Sep 2019 09:26:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqv9tdjacr.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28.09.2019 6:47, Junio C Hamano wrote:
> s/bugged/buggy/ perhaps?  Usually people do not place hidden
> listening devices in tests ;-)

Yes, hinting those hidden listening devices was an oversight. Thanks for 
your help in putting them back undercover!

I understand that you already changed the commit message, so I'm not 
submitting updated patch.
