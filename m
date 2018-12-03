Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84D84211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 20:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbeLCUuI (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 15:50:08 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:6485 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbeLCUuI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 15:50:08 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 437xvd4cqHz5tlC;
        Mon,  3 Dec 2018 21:50:05 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 627F112DF;
        Mon,  3 Dec 2018 21:50:05 +0100 (CET)
Subject: Re: [PATCH] rebase docs: fix incorrect format of the section
 Behavioral Differences
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <f26b53e3-e7d1-f0fe-cdd3-dd734beb1628@kdbg.org>
 <CAN0heSqfgu2A7Hg5b1Td-m_5gXtmd-8_ZBC5Fq9BDMaJD0yMqA@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3d8da8da-755f-7114-2274-77bd92720a83@kdbg.org>
Date:   Mon, 3 Dec 2018 21:50:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSqfgu2A7Hg5b1Td-m_5gXtmd-8_ZBC5Fq9BDMaJD0yMqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.12.18 um 21:42 schrieb Martin Ågren:
> On Mon, 3 Dec 2018 at 18:35, Johannes Sixt <j6t@kdbg.org> wrote:
>> I actually did not test the result, because I don't have the
>> infrastructure.
> 
> I've tested with asciidoc and Asciidoctor, html and man-page. Looks
> good.

Thank you so much!

-- Hannes
