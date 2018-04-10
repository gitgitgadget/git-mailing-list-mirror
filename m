Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EA0E1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 19:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeDJTWF (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 15:22:05 -0400
Received: from avasout04.plus.net ([212.159.14.19]:43362 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752434AbeDJTWB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 15:22:01 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id 5yq7fNwNNsD7b5yq8fMGBR; Tue, 10 Apr 2018 20:22:00 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=dGdKvbsqWLibG2eWM44A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: What's cooking in git.git (Apr 2018, #01; Mon, 9)
To:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com>
 <98394864-ece6-5112-0274-b2399087f207@gmail.com>
 <bba6e3ba-ab28-8cda-eab3-91ec3591bcb5@ramsayjones.plus.com>
 <xmqq4lkk58y0.fsf@gitster-ct.c.googlers.com>
 <b7644afa-3f5f-4caf-59dc-4ffc8ab0695a@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <73f2f53d-b73a-bdbe-01a5-8ed1d4fe6b00@ramsayjones.plus.com>
Date:   Tue, 10 Apr 2018 20:21:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b7644afa-3f5f-4caf-59dc-4ffc8ab0695a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHRLY8Kwr8TWmH1xljb994Q0uI4hetv2scHw6UQqs/sMxuCdycOR7omY6KORy3Zxk3kpxMcI4TjnmGw25ZnZoOMPSIx8MDMpT3O4llLZuTXCwO9Af1su
 CF2czrjnjJ794jAQZShGos3kz8JOlp//n/wCky7FXCkx4g3HWMyyLaBJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/04/18 13:57, Derrick Stolee wrote:
> On 4/9/2018 6:08 PM, Junio C Hamano wrote:
>>
>> I guess we'd want a final cleaned-up round after all ;-)  Thanks.
> 
> v8 sent [1]. Thanks.

I just tried to 'git am' this series and I could not get it
to apply cleanly to current 'master', 'next' or 'pu'. I fixed
up a few patches, but just got bored ... ;-)

ATB,
Ramsay Jones


