Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FC7B1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 11:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392426AbfHBLpH (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 07:45:07 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.95]:29843 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388886AbfHBLpH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 07:45:07 -0400
Received: from [87.165.18.83] (helo=[192.168.2.6])
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1htVzc-0002UJ-Bc; Fri, 02 Aug 2019 13:45:04 +0200
Subject: Re: Support for --stdin-paths in commit, add, etc
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com>
 <20190731171956.GA26746@sigill.intra.peff.net>
 <ab333992-35c6-a5a9-0bcb-cef51f004679@syntevo.com>
 <nycvar.QRO.7.76.6.1908021331590.46@tvgsbejvaqbjf.bet>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <2ed82d63-2a53-4aa8-a60b-d69150290a7f@syntevo.com>
Date:   Fri, 2 Aug 2019 13:45:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1908021331590.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02.08.2019 13:33, Johannes Schindelin wrote:
> Please note that I have a patch series (currently on hold because of the
> v2.23.0 feature freeze) to teach `git reset` an `--stdin` option:
> https://github.com/gitgitgadget/git/pull/133

Perfect! Less work for me :)
Once your patch is accepted, could you please send me a mail?
