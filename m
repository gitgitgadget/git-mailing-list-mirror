Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FFE61F403
	for <e@80x24.org>; Fri, 15 Jun 2018 15:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934212AbeFOPBY (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 11:01:24 -0400
Received: from avasout07.plus.net ([84.93.230.235]:52021 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754429AbeFOPBX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 11:01:23 -0400
Received: from [10.0.2.15] ([80.189.70.235])
        by smtp with ESMTPA
        id TqE5fjqAVjlDzTqE6fEdJz; Fri, 15 Jun 2018 16:01:22 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=YX39wz5waiCDnkc2J8opfw==:117 a=YX39wz5waiCDnkc2J8opfw==:17
 a=IkcTkHD0fZMA:10 a=yMhMjlubAAAA:8 a=U1l7MPOOfgbrisItt_kA:9 a=QEXdDO2ut3YA:10
 a=0bk-LgDcJPwA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 8/8] ewah_io: delete unused 'ewah_serialize_native()'
To:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
References: <f25c0798-7778-7146-5349-ae2c2fb560dd@ramsayjones.plus.com>
 <20180615143018.170686-1-dstolee@microsoft.com>
 <20180615143018.170686-9-dstolee@microsoft.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <57747146-2aea-39f4-0ef7-aca3a2ce0a66@ramsayjones.plus.com>
Date:   Fri, 15 Jun 2018 16:01:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615143018.170686-9-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFJCWvTJlxM4s3WBDaQLwgcZRCRwdHNXPG2qkc/HWpYPKdh/wKpJTapdc8I5Mupmd2SnC82R/lr9X5/QAk5Ybit21jdmacMpozVoSv23hrDEFN9MlkI1
 EAQiHymgwz4ER9369RstG35ORrlz8WQWti3983sKJljN4HLAeBfz539KLavUtyl45Qy/Z11BicB0Sg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/06/18 15:30, Derrick Stolee wrote:
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  ewah/ewah_io.c | 26 --------------------------
>  ewah/ewok.h    |  1 -
>  2 files changed, 27 deletions(-)

This duplicates Jeff's patch #3.

ATB,
Ramsay Jones
