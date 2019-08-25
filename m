Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85C041F461
	for <e@80x24.org>; Sun, 25 Aug 2019 17:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfHYRyj (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 13:54:39 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:16076 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbfHYRyj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 13:54:39 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 46GjSs1HC9z5tlC;
        Sun, 25 Aug 2019 19:54:36 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E0F94143;
        Sun, 25 Aug 2019 19:54:35 +0200 (CEST)
Subject: Re: [Feature Request] Option to make .git not read-only in cloned
 repos
To:     Albert Vaca Cintora <albertvaka@gmail.com>
References: <CAAQViEsZW4PzHr5BrkDHU2kSd_e04n02McGPgrmXGZMpgaTePg@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Message-ID: <d31b871a-5c2d-99e7-5616-6f43759bb948@kdbg.org>
Date:   Sun, 25 Aug 2019 19:54:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAAQViEsZW4PzHr5BrkDHU2kSd_e04n02McGPgrmXGZMpgaTePg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.08.19 um 22:43 schrieb Albert Vaca Cintora:
> However, I'm sure that a large percentage of developers out there will
> agree with me that having to use force (-f) to delete every cloned
> repo is annoying, and even worse, it creates the bad habit of always
> force-deleting everything.

IMO, the bad habit is to delete cloned repositories all the time. If
your workflow necessitates this, then you are doing something wrong.
Maybe you have an X-Y-problem?

-- Hannes
