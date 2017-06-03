Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ED9B1F7D2
	for <e@80x24.org>; Sat,  3 Jun 2017 01:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751493AbdFCBKU (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 21:10:20 -0400
Received: from renepasing.de ([5.9.148.133]:60696 "EHLO mail.renepasing.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751061AbdFCBKS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 21:10:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.renepasing.de (Postfix) with ESMTP id 08EF71001D9A;
        Sat,  3 Jun 2017 03:10:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.renepasing.de
Received: from mail.renepasing.de ([127.0.0.1])
        by localhost (mail.renepasing.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id wHhoq8K01la4; Sat,  3 Jun 2017 03:10:15 +0200 (CEST)
Received: from [IPv6:2a02:908:1064:9240:224:beff:fe38:eaca] (unknown [IPv6:2a02:908:1064:9240:224:beff:fe38:eaca])
        by mail.renepasing.de (Postfix) with ESMTPSA id C9EBF1000559;
        Sat,  3 Jun 2017 03:10:14 +0200 (CEST)
Subject: Re: Wrong gitattributes documentation?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <e7734a23-12b2-8f62-ab5c-c856d59e3010@pasing.net>
 <xmqq8tlax7lm.fsf@gitster.mtv.corp.google.com>
From:   Rene Pasing <rene@pasing.net>
Message-ID: <3b119d82-3d40-c48f-14b5-3348879aabc8@pasing.net>
Date:   Sat, 3 Jun 2017 03:10:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqq8tlax7lm.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/03/2017 02:01 AM, Junio C Hamano wrote:
> Your "/images/*" is the "Otherwise" case, isn't it?

Yes, true. I forgot to mention in my first mail that I also tried
'/images/', which had the same (=none) effect as '/images/*', sorry
about the confusion.


