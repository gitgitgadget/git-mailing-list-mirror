Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,T_HK_NAME_DR shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA48F1F462
	for <e@80x24.org>; Sun,  2 Jun 2019 09:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfFBJBh (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jun 2019 05:01:37 -0400
Received: from vwp8955.webpack.hosteurope.de ([176.28.35.119]:33708 "EHLO
        vwp8955.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbfFBJBg (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 2 Jun 2019 05:01:36 -0400
Received: from [2001:16b8:5cd7:8100:8dda:81bf:d984:b26b]; authenticated
        by vwp8955.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1hXMMw-00052m-IX; Sun, 02 Jun 2019 11:01:34 +0200
Subject: Re: [PATCH] make slash-rules more readable
To:     git@vger.kernel.org
References: <20190531074426.6810-1-admin@in-ici.net>
 <xmqqh89awprl.fsf@gitster-ct.c.googlers.com>
 <979f6497-5e26-4a93-c345-f61b31c736c6@talktalk.net>
From:   "Dr. Adam Nielsen" <admin@in-ici.net>
Message-ID: <37f3d5d3-80b0-c37d-23e6-d05e77fc498a@in-ici.net>
Date:   Sun, 2 Jun 2019 11:01:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <979f6497-5e26-4a93-c345-f61b31c736c6@talktalk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;admin@in-ici.net;1559466096;1e060e06;
X-HE-SMSGID: 1hXMMw-00052m-IX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On 01.06.19 11:33, Philip Oakley wrote:
>  From a user perspective, implementation issues shouldn't be part of the 
> description unless absolutely essential.
> 
> Most user aren't aware of the implementation so don't grok/understand 
> what the fuss is about and ignore it...

I agree with that. I will send another patch where I add the leading 
slash rule without going into implementation details.




