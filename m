Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6079A20248
	for <e@80x24.org>; Mon, 25 Feb 2019 20:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfBYU1O (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 15:27:14 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:4073 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfBYU1O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 15:27:14 -0500
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 0A3A62003DC
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 21:27:12 +0100 (CET)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.21.0
Date:   Mon, 25 Feb 2019 21:27:12 +0100
Message-ID: <4204994.SWqPrGqdvb@cayenne>
In-Reply-To: <xmqqtvgtkq46.fsf@gitster-ct.c.googlers.com>
References: <xmqqtvgtkq46.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all, 

On localization of the manpages

Some work was started in German and French. Some other languages were added
but with no further work.

For v2.21.0, pages are only generated in French for add, checkout, commit, stage.
The work on German did not reach the threshold of 80% translated to trigger 
the generation.

If you want to have the git's manpages in you language, join the project!

https://github.com/jnavila/git-manpages-l10n




