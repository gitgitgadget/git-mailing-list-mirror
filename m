Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3B221F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 21:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbeJKEtO (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 00:49:14 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:5910 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbeJKEtO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 00:49:14 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42VnF3738Tz5tlY;
        Wed, 10 Oct 2018 23:25:11 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 46BFF41A1;
        Wed, 10 Oct 2018 23:25:11 +0200 (CEST)
Subject: Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
To:     Alban Gruin <alban.gruin@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3362a7a4-bb03-66a1-0f3f-929fd4b09195@kdbg.org>
Date:   Wed, 10 Oct 2018 23:25:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.10.18 um 07:43 schrieb Junio C Hamano:
> We haven't seen much complaints and breakages reported against the
> two big "rewrite in C" topics around "rebase"; perhaps it is a good
> time to merge them to 'next' soonish to cook them for a few weeks
> before moving them to 'master'?

Please let me express my sincerest gratitude to Alban, Joel, 
Paul-Sebastian, Pratik, and Dscho. It is such a pleasure to work with 
the builtin rebase and stash commands on Windows now. I am using them 
since a month or two, and they work extremely well for me.

Thank you all for your hard work!

-- Hannes
