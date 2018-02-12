Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDFAB1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 18:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbeBLSV3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 13:21:29 -0500
Received: from siwi.pair.com ([209.68.5.199]:48265 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752515AbeBLSV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 13:21:29 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 9C1EF3F40DE;
        Mon, 12 Feb 2018 13:21:28 -0500 (EST)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 75BDF3F40DC;
        Mon, 12 Feb 2018 13:21:28 -0500 (EST)
Subject: Re: partial fetch
To:     Basin Ilya <basinilya@gmail.com>, git@vger.kernel.org
References: <3086333a-031d-0c98-a610-d5e36992d298@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c05e40f6-b985-da16-7172-be2dedbb3736@jeffhostetler.com>
Date:   Mon, 12 Feb 2018 13:21:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <3086333a-031d-0c98-a610-d5e36992d298@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/12/2018 11:24 AM, Basin Ilya wrote:
> Hi.
> In 2017 a set of patches titled "add object filtering for partial fetch" was accepted. Is it what I think it is? Will we be able to download only a subdirectory from a
> large project?
> 

yes, that is the goal.
there are several caveats, but yes, that is the goal.

Jeff
