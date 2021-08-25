Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A8EC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 05:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F50361368
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 05:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhHYFsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 01:48:00 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:44228 "EHLO shell1.rawbw.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232420AbhHYFsA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 01:48:00 -0400
Received: from yv.noip.me (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 17P5lE8g052488
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 24 Aug 2021 22:47:14 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be yv.noip.me
Subject: Re: 'git pull' complains that a locally resurrected directory would
 be overwritten by merge when no pulled changes are affecting that directory
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <01514401-78f6-3fdc-aa74-c519fb6ab427@rawbw.com>
 <2fe5e6c2-3887-6d7d-7240-2aa9f0e70873@gmail.com>
From:   Yuri <yuri@rawbw.com>
Message-ID: <acbc5ec8-fe21-3c8e-8f4f-e3be3126c2ed@rawbw.com>
Date:   Tue, 24 Aug 2021 22:47:12 -0700
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2fe5e6c2-3887-6d7d-7240-2aa9f0e70873@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/24/21 10:43 PM, Bagas Sanjaya wrote:
> Have you committed or stashed such changes? 


No, they were uncommitted and unstashed.


Yuri


