Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E001C1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 21:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfJKVfa (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 17:35:30 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:52389 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfJKVf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 17:35:29 -0400
X-Originating-IP: 1.186.12.63
Received: from localhost (unknown [1.186.12.63])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 36EB61C0003;
        Fri, 11 Oct 2019 21:35:26 +0000 (UTC)
Date:   Sat, 12 Oct 2019 03:05:24 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-gui: add a readme
Message-ID: <20191011213524.i2zo4oxkpui3tzth@yadavpratyush.com>
References: <20191004221052.23313-1-me@yadavpratyush.com>
 <20191008121735.29531-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008121735.29531-1-me@yadavpratyush.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll take the silence to mean there are no further objections, and will 
merge this version in to 'master'.

On 08/10/19 05:47PM, Pratyush Yadav wrote:
> It is a good idea to have a readme so people finding the project can
> know more about it, and know how they can get involved.
> 
> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> ---
> Changes in v3:
> - Reword the first paragraph to avoid some repetition. Suggested by
>   Junio.
> - Do not mention "written in Tcl" in the intro. Suggested by Junio.
> - Add a list of dependencies.

-- 
Regards,
Pratyush Yadav
