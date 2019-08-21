Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D5911F461
	for <e@80x24.org>; Wed, 21 Aug 2019 14:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfHUOgQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 10:36:16 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:15330 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728567AbfHUOgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 10:36:16 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1i0Rig-0000kc-4B; Wed, 21 Aug 2019 15:36:14 +0100
Subject: Re: [ANNOUNCE] Git Rev News edition 54
To:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
References: <CAP8UFD3h=GNEFbVUWKBMpYFUNqOaDCkxyeq5Vu2kGst_uBE0eA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <62a106a2-a0b7-c268-5c0f-d727b44f3ecc@iee.email>
Date:   Wed, 21 Aug 2019 15:36:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD3h=GNEFbVUWKBMpYFUNqOaDCkxyeq5Vu2kGst_uBE0eA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/08/2019 15:01, Christian Couder wrote:
> Hi everyone,
>
> The 54th edition of Git Rev News is now published:
>
>    https://git.github.io/rev_news/2019/08/21/edition-54/
>
> Thanks a lot to Elijah Newren, Jeff Hostetler, Andrew Ardill and
> Jean-Noël Avila who contributed this month!
>
> Enjoy,
> Christian, Jakub, Markus and Gabriel.

Thanks.

Jean-Noël's comment

     "As an aside, providing a po file for core strings and another one 
for less used strings would also help kickstart translations by focusing 
on more productive work for translators of new languages."

  sounds like a possible project idea for capturing usage counts by 
instrumenting the _() function to count how often those 4674 po strings 
are used over some duration, especially in larger establishments with a 
range of users..

Maybe something for the project ideas files.

Philip
