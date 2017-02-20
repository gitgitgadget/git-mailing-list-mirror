Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 154FD201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 12:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbdBTMlu (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 07:41:50 -0500
Received: from smtp2-2.goneo.de ([85.220.129.34]:46837 "EHLO smtp2-2.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751436AbdBTMlt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 07:41:49 -0500
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Feb 2017 07:41:49 EST
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 4E66024394D
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 13:36:21 +0100 (CET)
X-Virus-Scanned: by goneo
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id p3vP13qIw6DH for <git@vger.kernel.org>;
        Mon, 20 Feb 2017 13:36:11 +0100 (CET)
Received: from [192.168.0.165] (ip-88-153-200-99.hsi04.unitymediagroup.de [88.153.200.99])
        by smtp2.goneo.de (Postfix) with ESMTPSA id 4D154243A4D
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 13:35:19 +0100 (CET)
To:     git@vger.kernel.org
From:   Leon George <leon@georgemail.eu>
Subject: slightly confusing message
Message-ID: <7cca3326-d6b5-4669-7256-ab275567b72e@georgemail.eu>
Date:   Mon, 20 Feb 2017 13:35:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey, you lovely people <3

Every once in a while this:

£ git add -p .
warning: empty strings as pathspecs will be made invalid in upcoming
releases. please use . instead if you meant to match all paths
No changes.

It seems to happen only when there are no more modified files and git
still works wonderfully otherwise - just wanted to let you know.

enjoy your weeks :-)
