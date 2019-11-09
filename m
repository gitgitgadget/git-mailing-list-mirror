Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD88E1F454
	for <e@80x24.org>; Sat,  9 Nov 2019 19:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfKITbX (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Nov 2019 14:31:23 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:18075 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfKITbX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Nov 2019 14:31:23 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 479S1N5y4gz5tlC;
        Sat,  9 Nov 2019 20:31:20 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C27714AEA;
        Sat,  9 Nov 2019 20:31:19 +0100 (CET)
Subject: Re: [PATCH v4] userdiff: add Elixir to supported userdiff languages
To:     =?UTF-8?Q?=c5=81ukasz_Niemier?= <lukasz@niemier.pl>
References: <20191106234941.48926-1-lukasz@niemier.pl>
 <20191108213824.11622-1-lukasz@niemier.pl>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5a8639a6-0a47-1a11-3886-f5512474b364@kdbg.org>
Date:   Sat, 9 Nov 2019 20:31:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191108213824.11622-1-lukasz@niemier.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.11.19 um 22:38 schrieb Łukasz Niemier:
> Adds support for xfuncref in Elixir[1] language which is Ruby-like
> language that runs on Erlang[3] Virtual Machine (BEAM).
> 
> [1]: https://elixir-lang.org
> [2]: https://www.erlang.org
> 
> Signed-off-by: Łukasz Niemier <lukasz@niemier.pl>
> ---
> Add entry to the documentation of gitattributes as well.

Oh, yes! Thanks for being diligent! Let me repeat my

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
