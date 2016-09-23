Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30A96207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 19:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761882AbcIWTYQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 15:24:16 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:54000 "EHLO bsmtp4.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761877AbcIWTYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 15:24:16 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp4.bon.at (Postfix) with ESMTPSA id 3sgjwF4lHZz5tlG;
        Fri, 23 Sep 2016 21:24:13 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id AC45B519D;
        Fri, 23 Sep 2016 21:24:12 +0200 (CEST)
Subject: Re: Limitiations of git rebase --preserve-merges --interactive
To:     Stefan Haller <lists@haller-berlin.de>
References: <1mu1iqo.1gihw0m1dcenmnM%lists@haller-berlin.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anatoly Borodin <anatoly.borodin@gmail.com>,
        git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4a9ebaaf-cf0e-7662-1799-df39597b43be@kdbg.org>
Date:   Fri, 23 Sep 2016 21:24:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1mu1iqo.1gihw0m1dcenmnM%lists@haller-berlin.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.09.2016 um 17:50 schrieb Stefan Haller:
> And I don't see any tests that do rebase -p -i and actually do something
> interesting with the -i part. So my original question still remains. :-)

-i -p came first. -p without -i was bolted on later.

-- Hannes

