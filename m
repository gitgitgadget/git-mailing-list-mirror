Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A41C20954
	for <e@80x24.org>; Wed, 22 Nov 2017 20:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbdKVUjc convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 22 Nov 2017 15:39:32 -0500
Received: from marot.dh.bytemark.co.uk ([212.110.172.17]:39066 "EHLO
        marot.bettens.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbdKVUjb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 15:39:31 -0500
Received: by marot.bettens.info (Sendmail new on BidulOS, from userid 65534)
        id 5E69157058D; Wed, 22 Nov 2017 21:39:30 +0100 (CET)
Received: from machaut.bettens.info (dslgva4378.worldcom.ch [83.172.215.76])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by marot.bettens.info (Sendmail new on BidulOS) with ESMTPS id 2080E57057F;
        Wed, 22 Nov 2017 21:39:28 +0100 (CET)
Received: from [192.168.1.9] (dslgva4378.worldcom.ch [83.172.215.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by machaut.bettens.info (Postfix) with ESMTPSA id 7E29F914;
        Wed, 22 Nov 2017 21:39:24 +0100 (CET)
Date:   Wed, 22 Nov 2017 21:39:24 +0100
From:   Louis Bettens <louis@bettens.info>
Subject: Re: [PATCH] fix french translation
To:     =?iso-8859-1?q?Jean-No=EBl?= AVILA <jn.avila@free.fr>
Cc:     git@vger.kernel.org, worldhello.net@gmail.com
Message-Id: <1511383164.854.8@machaut.bettens.info>
In-Reply-To: <3937091.4fae5A5SOV@cayenne>
References: <20171122172440.15106-1-louis@bettens.info>
        <20171122172440.15106-2-louis@bettens.info> <3937091.4fae5A5SOV@cayenne>
X-Mailer: geary/0.12-dev
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks!

Bye

Le mer 22 nov 2017 à 21:17, Jean-Noël AVILA <jn.avila@free.fr> a 
écrit :
> On Wednesday, 22 November 2017 18:24:40 CET Louis Bettens wrote:
>>  Signed-off-by: Louis Bettens <louis@bettens.info>
>>  ---
>>   po/fr.po | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>>  diff --git a/po/fr.po b/po/fr.po
>>  index 4deae3318..a12a2ae37 100644
>>  --- a/po/fr.po
>>  +++ b/po/fr.po
>>  @@ -14331,7 +14331,7 @@ msgstr "git worktree add [<options>] 
>> <chemin> [<branche>]"
>> 
>>   #: builtin/worktree.c:17
>>   msgid "git worktree list [<options>]"
>>  -msgstr "git worktree prune [<options>]"
>>  +msgstr "git worktree list [<options>]"
>> 
>>   #: builtin/worktree.c:18
>>   msgid "git worktree lock [<options>] <path>"
>> 
> 
> Good catch! I guess the segment switched directly from fuzzy to 
> translated.
> 
> I'll queue it for the next version which we should not wait for long.
> 
> Thanks
> 

