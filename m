Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ADDC1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 21:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbeHAWtD (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 18:49:03 -0400
Received: from avasout07.plus.net ([84.93.230.235]:44568 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730513AbeHAWtD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 18:49:03 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id kyFFfzEBRjlDzkyFHfdYVm; Wed, 01 Aug 2018 22:01:23 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=vcmZA8ZfLpIKtnvdUKMA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/3] config: fix case sensitive subsection names on
 writing
To:     Stefan Beller <sbeller@google.com>, gitster@pobox.com
Cc:     bmwill@google.com, git@vger.kernel.org, johannes.schindelin@gmx.de,
        peff@google.com
References: <xmqq7elbe8po.fsf@gitster-ct.c.googlers.com>
 <20180801193413.146994-1-sbeller@google.com>
 <20180801193413.146994-3-sbeller@google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <15bd43c8-361a-eb05-3712-e9fd02428b72@ramsayjones.plus.com>
Date:   Wed, 1 Aug 2018 22:01:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801193413.146994-3-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHcJaPV0S/1D2vtVEtnMVhHhsR2R2jrC5D9dOUMm2NZCRmMQ0e4GxGqMxu7RwoRNaNP9HWAzDlO3dyfBiqcwIHMALpjwNq4/PVXa8iaH1lJEV5NW0LHf
 DbRqT5MAE8XPYnTBSIampd2PdlV8Acaa5BtEqQjSL1bPHVHcvqiGTiioMGd0rKPjuUm0Y/xayhP1fQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 01/08/18 20:34, Stefan Beller wrote:
> A use reported a submodule issue regarding strange case indentation

s/use/user/ ?

ATB,
Ramsay Jones

