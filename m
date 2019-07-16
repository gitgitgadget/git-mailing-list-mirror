Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73D651F461
	for <e@80x24.org>; Tue, 16 Jul 2019 18:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388344AbfGPSKA (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 14:10:00 -0400
Received: from 79-149-172-163.rev.cloud.scaleway.com ([163.172.149.79]:38834
        "EHLO eyoman.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbfGPSKA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 14:10:00 -0400
Received: by eyoman.com (Postfix, from userid 1004)
        id B3BAB18059C; Tue, 16 Jul 2019 21:09:57 +0300 (IDT)
Received: from zen (unknown [176.230.45.210])
        by eyoman.com (Postfix) with ESMTPA id 96EFD1800F6;
        Tue, 16 Jul 2019 21:09:56 +0300 (IDT)
Date:   Tue, 16 Jul 2019 21:10:12 +0300
From:   Daniel Zaoui <jackdanielz@eyomi.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Weird behavior with git grep --recurse-submodules
Message-ID: <20190716211012.226b7059@zen>
In-Reply-To: <nycvar.QRO.7.76.6.1907101313450.46@tvgsbejvaqbjf.bet>
References: <20190708111459.135abe50@zen>
        <CAHd-oW5Q1PWDzWKpsmdv4ecUMrQTj4Vyh_SoVu6vaFeSFmxE5g@mail.gmail.com>
        <nycvar.QRO.7.76.6.1907101313450.46@tvgsbejvaqbjf.bet>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

Thank you for your response.

I really hope the change Brandon made is not a project decision. At least, it does seem to me like a bug.

How do you recommend me to solve this issue? Is there some place where I can check if some bug ticket has been created on this matter? I didn't find anything in the mailing list archives about this.

BR
Daniel

On Wed, 10 Jul 2019 13:14:18 +0200 (CEST)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> [cC:ing Brandon via his current email address, as per .mailmap]
> 
> 
> On Wed, 10 Jul 2019, Matheus Tavares Bernardino wrote:
> 
>  [...]  
>  [...]  
>  [...]  
>  [...]  
>  [...]  
>  [...]  
>  [...]  

