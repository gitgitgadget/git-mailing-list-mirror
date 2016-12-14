Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EF2F203C1
	for <e@80x24.org>; Wed, 14 Dec 2016 07:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754883AbcLNHIi (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 02:08:38 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:52122 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753490AbcLNHIg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 02:08:36 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tdnjZ09D7z5tlH;
        Wed, 14 Dec 2016 08:08:33 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 32F521E61;
        Wed, 14 Dec 2016 08:08:33 +0100 (CET)
Subject: Re: [PATCH v2 00/34] Teach the sequencer to act as rebase -i's
 backend
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
 <cover.1481642927.git.johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <9d399b83-92c6-44e9-8415-7695e690e8be@kdbg.org>
Date:   Wed, 14 Dec 2016 08:08:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.12.2016 um 16:29 schrieb Johannes Schindelin:
> base-commit: 8d7a455ed52e2a96debc080dfc011b6bb00db5d2
> Published-As: https://github.com/dscho/git/releases/tag/sequencer-i-v2
> Fetch-It-Via: git fetch https://github.com/dscho/git sequencer-i-v2

Thank you so much!

I would appreciate if you could publish a branch that contains the end 
game so that I can test it, too. Currently I am still using

  git://github.com/dscho/git interactive-rebase (fca871a3cf4d)

-- Hannes

