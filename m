Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7016C20282
	for <e@80x24.org>; Sun, 11 Jun 2017 18:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751911AbdFKSak convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 11 Jun 2017 14:30:40 -0400
Received: from elephants.elehost.com ([216.66.27.132]:21394 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbdFKSaj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2017 14:30:39 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.238.41.215])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id v5BIUVN4062001
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 11 Jun 2017 14:30:32 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Igor Djordjevic'" <igor.d.djordjevic@gmail.com>,
        "'liam Beguin'" <liambeguin@gmail.com>,
        "'Jeff King'" <peff@peff.net>, "'Samuel Lijin'" <sxlijin@gmail.com>
Cc:     "'Houston Fortney'" <houstonfortney@gmail.com>,
        <git@vger.kernel.org>
References: <CA+B9myHRahTd+FDgzK5AhXW+hq_Y_czMX9X6MXYBcr9WSPeiDw@mail.gmail.com> <20170610082534.6437ifexzly4oqg6@sigill.intra.peff.net> <CAJZjrdXCHVKQOxR=+z5cOkieKzE-iSMta--kHVjSYXuansb34Q@mail.gmail.com> <20170610102217.vxf6tsrdfp6srupr@sigill.intra.peff.net> <1c04d689-6796-17d1-e058-18874768c22a@gmail.com> <000b01d2e2dc$327c11c0$97743540$@nexbridge.com> <11f1877a-6ec3-02c1-5b06-c1a07a389010@gmail.com>
In-Reply-To: <11f1877a-6ec3-02c1-5b06-c1a07a389010@gmail.com>
Subject: RE: Feature Request: Show status of the stash in git status command
Date:   Sun, 11 Jun 2017 14:30:23 -0400
Message-ID: <000c01d2e2e0$cda526b0$68ef7410$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHZQ29ArhOS7YAPjT7jPvdwYR36LAFpCkanAbqFlqUCB25i+wFkDR0/ApLLeW8DCcTHuqGx3XrQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 11, 2017 2:19 PM  Igor Djordjevic wrote: 
>On 11/06/2017 19:57, Randall S. Becker wrote:
>> Random thought: what if a stash id could be used in the same way as 
>> any other ref, so diff stash[0] stash[1] would be possible - although 
>> I can see this being problematic for a merge or rebase.
>Not sure if I`m misunderstanding you, but at least `git diff stash@{0} stash@{1}` seems to already work as expected - I remember using it in the past, >and I`ve tried it again now[1], and it still works.

I'm sorry for not checking first before posting. Thanks 😊

Randall

