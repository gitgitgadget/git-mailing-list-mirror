Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF4351F463
	for <e@80x24.org>; Thu, 12 Sep 2019 22:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfILWQB (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 18:16:01 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:9767 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfILWQB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 18:16:01 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1i8XNf-0007YL-90; Thu, 12 Sep 2019 23:16:00 +0100
Subject: Re: [PATCH] git-gui: convert new/amend commit radiobutton to
 checketton
To:     Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
References: <41ebf78fbe8af587c739c08aa6f20cf76c602775.1568317431.git.bert.wesarg@googlemail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <b3f1cd2b-7462-89fd-ff2d-9e53da286027@iee.email>
Date:   Thu, 12 Sep 2019 23:15:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <41ebf78fbe8af587c739c08aa6f20cf76c602775.1568317431.git.bert.wesarg@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/09/2019 20:44, Bert Wesarg wrote:
> Its a bi-state anyway and also safes one line in the menu.
s/safes/saves/  ?

>
> Signed-off-by: Bert Wesarg<bert.wesarg@googlemail.com>
> ---
Philip
