Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A79F20899
	for <e@80x24.org>; Thu, 27 Jul 2017 15:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbdG0Pw4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 11:52:56 -0400
Received: from avasout06.plus.net ([212.159.14.18]:42269 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdG0Pwz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 11:52:55 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout06 with smtp
        id prst1v00118PUFB01rsuYV; Thu, 27 Jul 2017 16:52:54 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=GetnpUfL c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=iIkAcHe-3e0y4_TmHTQA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] credential-cache: interpret an ECONNRESET as on EOF
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Devin Lehmacher <lehmacdj@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        GIT Mailing-list <git@vger.kernel.org>
References: <ab9124d9-6630-49f3-d645-2f4251f88764@ramsayjones.plus.com>
Message-ID: <ce4630ad-78e9-3163-1582-773b0e9fde02@ramsayjones.plus.com>
Date:   Thu, 27 Jul 2017 16:52:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <ab9124d9-6630-49f3-d645-2f4251f88764@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I just noticed a typo in the subject line for this patch. It should
read '... ECONNRESET as _an_ EOF' not '... ECONNRESET as _on_ EOF'.

[complete patch snipped!]

Thanks!

ATB,
Ramsay Jones
