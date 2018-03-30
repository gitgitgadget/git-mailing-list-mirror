Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B50A71F404
	for <e@80x24.org>; Fri, 30 Mar 2018 21:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbeC3Vvr (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 17:51:47 -0400
Received: from siwi.pair.com ([209.68.5.199]:14802 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752125AbeC3Vvq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 17:51:46 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 364CB3F401C;
        Fri, 30 Mar 2018 17:51:46 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1AA203F401B;
        Fri, 30 Mar 2018 17:51:46 -0400 (EDT)
Subject: Re: What's cooking in git.git (Mar 2018, #06; Fri, 30)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqvadd1epf.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <231a5383-f7a9-7df8-576e-21a81b255530@jeffhostetler.com>
Date:   Fri, 30 Mar 2018 17:51:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqvadd1epf.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/30/2018 4:38 PM, Junio C Hamano wrote:
> 
> * jh/json-writer (2018-03-28) 1 commit
>   - json_writer: new routines to create data in JSON format
> 
>   Is this ready for 'next'?

Yes, I believe it is.  This has the V6 fixup for the HEREDOC
with leading whitespace, so I think we're good.

Thanks
Jeff

