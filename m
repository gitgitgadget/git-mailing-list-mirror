Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7D6B1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 20:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732809AbfIPUUM convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 16 Sep 2019 16:20:12 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:35987 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbfIPUUM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 16:20:12 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 731BB20041A
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 22:20:11 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     git@vger.kernel.org
Subject: Re: Git documentation in Azerbaijan language
Date:   Mon, 16 Sep 2019 22:20:11 +0200
Message-ID: <1778067.ZynlgHOFDf@cayenne>
In-Reply-To: <20a404f4-929e-fb87-4ae5-b0e8707b15c7@gmail.com>
References: <20a404f4-929e-fb87-4ae5-b0e8707b15c7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, 16 September 2019 14:50:17 CEST Alicenab wrote:
> Hello,
> As far as I know Git documentation does not have Azerbaijan language 
> translation. I have started to work around it. Are you open for this 
> commitment?
> 
> Best regards
> Ali
> 

Hello and welcome,

There are different things that can be translated in Git and Git's 
documentation:

There are the manual pages of Git. You can read about translating them here:

  https://github.com/jnavila/git-manpages-l10n 

There are also translations of the "Pro Git" book. This isn't strictly
"Git documentation", but it is CC-licensed and is published at
https://git-scm.com. Details are at:

  https://github.com/progit/progit2/blob/master/TRANSLATING.md

Finally, there is the documentation embedded in Git itself, which can be 
translated from here:

  https://github.com/git-l10n/git-po

If  you are just starting a translation, I would recommend heading first to 
Progit, which is the simplest to translate in terms of tooling.

In any case, if you need help for starting up, just contact me.

Best regards,

Jean-Noël


