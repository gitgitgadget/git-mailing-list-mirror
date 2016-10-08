Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 823D6207EC
	for <e@80x24.org>; Sat,  8 Oct 2016 07:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757965AbcJHHq2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 03:46:28 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:57429 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754730AbcJHHq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 03:46:27 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3srdk82KY9z5tlC;
        Sat,  8 Oct 2016 09:46:24 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 96E7229BD;
        Sat,  8 Oct 2016 09:46:23 +0200 (CEST)
Subject: Re: [PATCH v4 4/4] mergetool: honor -O<orderfile>
To:     David Aguilar <davvid@gmail.com>
References: <20161008000130.22858-1-davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Luis Gutierrez <luisgutz@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a0725074-b82e-06dd-13b8-7730cbebe50c@kdbg.org>
Date:   Sat, 8 Oct 2016 09:46:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161008000130.22858-1-davvid@gmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With this final fixup, the series looks good to me, and I have no 
further comments.

Reviewed-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes

