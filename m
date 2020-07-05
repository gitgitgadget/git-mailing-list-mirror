Return-Path: <SRS0=5lEM=AQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15C8C433E0
	for <git@archiver.kernel.org>; Sun,  5 Jul 2020 10:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A001920771
	for <git@archiver.kernel.org>; Sun,  5 Jul 2020 10:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgGEKwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jul 2020 06:52:36 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:22413 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgGEKwg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jul 2020 06:52:36 -0400
Received: from host-92-20-155-32.as13285.net ([92.20.155.32] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1js2GA-0008tu-3H; Sun, 05 Jul 2020 11:52:34 +0100
Subject: Re: [PATCH 1/4] submodule: amend extra line feed between callback
 struct and macro
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, kaartic.sivaraam@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com
References: <20200702192409.21865-1-shouryashukla.oo@gmail.com>
 <20200702192409.21865-2-shouryashukla.oo@gmail.com>
 <nycvar.QRO.7.76.6.2007031653570.50@tvgsbejvaqbjf.bet>
 <8a36a3cd-02a3-f4fa-7b86-0d4884c88449@iee.email>
 <20200704152104.GA45598@konoha> <20200704153917.GD4087@danh.dev>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <0028d1be-9479-b761-8617-cc73c4bb3858@iee.email>
Date:   Sun, 5 Jul 2020 11:52:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200704153917.GD4087@danh.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/07/2020 16:39, Đoàn Trần Công Danh wrote:
> On 2020-07-04 20:51:04+0530, Shourya Shukla <shouryashukla.oo@gmail.com> wrote:
>> On 03/07 04:37, Philip Oakley wrote:
>>> Suggestion...
>>>
>>> On 03/07/2020 15:57, Johannes Schindelin wrote:
>>>> Maybe a native reader can suggest something that flows a bit easier? I am
>>>> not a native English speaker, but I'd prefer something along those lines:
>>>>
>>>> 	Many `submodule--helper` subcommands follow the convention a
>>> s/convention a/convention that a/    feels nicer for me
>> I did not get this one. Are you asking to replace "convention" with "a"
>> only?
> He probably meant put "that" between "convention" and "a"
> Pull ed/vi/sed out and that try this command on that line :)
>
> 	s/convention a/convention that a/
>
>
Correct.

Philip
