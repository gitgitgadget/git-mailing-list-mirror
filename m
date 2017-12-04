Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2BDA20954
	for <e@80x24.org>; Mon,  4 Dec 2017 22:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752932AbdLDWEl (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 17:04:41 -0500
Received: from siwi.pair.com ([209.68.5.199]:52382 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752674AbdLDWEl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 17:04:41 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 861A3844E9;
        Mon,  4 Dec 2017 17:04:40 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5DD6A844E8;
        Mon,  4 Dec 2017 17:04:40 -0500 (EST)
Subject: Re: What's cooking in git.git (Dec 2017, #01; Mon, 4)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <65f9d6af-7f74-afab-4ee8-17077c3e3207@jeffhostetler.com>
Date:   Mon, 4 Dec 2017 17:04:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/4/2017 4:46 PM, Junio C Hamano wrote:
> * cc/object-filtering-typofix (2017-12-04) 1 commit
>   - list-objects-filter-options: fix 'keword' typo in comment
>   (this branch uses jh/object-filtering; is tangled with jh/fsck-promisors and jh/partial-clone.)
> 
>   Typofix for a topic already in 'next'.
> 
>   JeffH said that jh/object-filtering needs further polishing a bit
>   before graduating to 'master', so it would be appreciated if this
>   can also be rolled into such an incremental update.

I've pulled this into my branch and will include it in my V6 update.
Thanks
jeff

