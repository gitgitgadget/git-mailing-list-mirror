Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE23220A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 07:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbeLLH3t (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 02:29:49 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:48055 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbeLLH3t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 02:29:49 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43F7k31YDwz5tlL;
        Wed, 12 Dec 2018 08:29:47 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 89107DC;
        Wed, 12 Dec 2018 08:29:46 +0100 (CET)
Subject: Re: [PATCH v2 1/3] git clone <url> C:\cygwin\home\USER\repo' is
 working (again)
To:     Steven Penny <svnpenn@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
 <20181207170456.8994-1-tboegi@web.de>
 <CAAXzdLVTjCVDmBik-j9B_Z_2wgSj=_6baqmjmGEGBFOsjkyOsw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1812100938140.43@tvgsbejvaqbjf.bet>
 <CAAXzdLUKhCfvqdvsPryeMGJ2ttJxof4sUcyTx-xd5p2BaoryiQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1812111429320.43@tvgsbejvaqbjf.bet>
 <CAAXzdLU7dJGOW689tDkYuRYko1zYHXMcj_2PaVa0qStYA7ELNw@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <be24f331-5c8f-954d-e6f5-d5b09ee4e5f3@kdbg.org>
Date:   Wed, 12 Dec 2018 08:29:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAAXzdLU7dJGOW689tDkYuRYko1zYHXMcj_2PaVa0qStYA7ELNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.12.18 um 01:42 schrieb Steven Penny:
> On Tue, Dec 11, 2018 at 7:39 AM Johannes Schindelin wrote:
>>> - pc-windows
>>> - pc-win
>>> - win
>>
>> I find all of those horrible.
> 
> one windows triplet in use is "x86_64-pc-windows", used by Rust:
> 
> https://forge.rust-lang.org/other-installation-methods.html
> 
> which is how i came about my suggestions - again they arent great but they arent
> misleading as "Win32" is.

As long as C:\Windows\System32 on my Windows computer contains only 
64-Bit binaries, I consider the characters "3" and "2" next to each 
other in this order just noise and without any form of information. The 
important part of the name is "win".

-- Hannes
