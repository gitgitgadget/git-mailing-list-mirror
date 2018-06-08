Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2BFC1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753116AbeFHWJY (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:09:24 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:51714 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753037AbeFHWJY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:09:24 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 412c5G2cScz5tlC;
        Sat,  9 Jun 2018 00:09:22 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id DF48E3B5;
        Sat,  9 Jun 2018 00:09:21 +0200 (CEST)
Subject: Re: GDPR compliance best practices?
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>, David Lang <david@lang.hm>,
        Philip Oakley <philipoakley@iee.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <87tvqk81qp.fsf@evledraar.gmail.com>
 <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
 <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
 <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz>
 <20180607063225.GA28343@helen.PLASMA.Xg8.DE>
 <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley>
 <20180607223442.GA5322@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz>
 <20180607232128.GA5879@helen.PLASMA.Xg8.DE>
 <20180608025313.GA12749@thunk.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <bb9d72e4-cae1-74f6-60b7-f12d46fddb1d@kdbg.org>
Date:   Sat, 9 Jun 2018 00:09:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608025313.GA12749@thunk.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.06.2018 um 04:53 schrieb Theodore Y. Ts'o:
> And of course, that's the other thing you seem to fundamentally not
> understand about how git works.  Every developer in the world working
> on that open source project has their own copy.

Everyone here understands how Git works, of course.

"*shrug* but that's how Git works" does *NOT* override the GDPR.

-- Hannes
