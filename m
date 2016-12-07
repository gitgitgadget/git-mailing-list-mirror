Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DCBD1FBB0
	for <e@80x24.org>; Wed,  7 Dec 2016 11:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbcLGLHH (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 06:07:07 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.27]:43448 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbcLGLHG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 06:07:06 -0500
X-Greylist: delayed 2464 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Dec 2016 06:07:06 EST
Received: from [91.113.179.170] (helo=[192.168.92.11])
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
        (Exim 4.84)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1cEZQ9-0001NO-U9
        for git@vger.kernel.org; Wed, 07 Dec 2016 11:25:54 +0100
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Subject: [ANNOUNCE] DeepGit - free cross-platform Git blame GUI with code move
 detection
To:     git@vger.kernel.org
Message-ID: <e0f1487b-863a-7d45-6c25-49e48e4d44db@syntevo.com>
Date:   Wed, 7 Dec 2016 11:26:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have just released the first version of DeepGit, a free 
cross-platform tool to investigate the history of source code. It's 
based on blame information and comes with a 'fuzzy' line/block move 
detection.

http://www.syntevo.com/deepgit/

-Marc
