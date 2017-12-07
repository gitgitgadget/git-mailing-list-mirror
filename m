Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C3D20954
	for <e@80x24.org>; Thu,  7 Dec 2017 12:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753339AbdLGMn6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 07:43:58 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:49358 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753003AbdLGMn5 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2017 07:43:57 -0500
X-IronPort-AV: E=Sophos;i="5.45,373,1508796000"; 
   d="scan'208";a="304410370"
Received: from orange.lip.ens-lyon.fr ([140.77.14.54])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-GCM-SHA256; 07 Dec 2017 13:43:55 +0100
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     BENSOUSSAN--BOHM DANIEL p1507430 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ALBERTIN TIMOTHEE p1514771 
        <timothee.albertin@etu.univ-lyon1.fr>,
        "Michael Haggerty" <mhagger@alum.mit.edu>,
        PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] doc: clarify triangular workflow
References: <1512034932-14499-1-git-send-email-timothee.albertin@etu.univ-lyon1.fr>
        <xmqqwp24iah2.fsf@gitster.mtv.corp.google.com>
        <24f652b96fd940ee91e2741830382a72@BPMBX2013-01.univ-lyon1.fr>
Date:   Thu, 07 Dec 2017 13:43:48 +0100
In-Reply-To: <24f652b96fd940ee91e2741830382a72@BPMBX2013-01.univ-lyon1.fr>
        (BENSOUSSAN--BOHM DANIEL's message of "Thu, 7 Dec 2017 09:26:18
        +0000")
Message-ID: <q7h9y3meoghn.fsf@orange.lip.ens-lyon.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

BENSOUSSAN--BOHM DANIEL p1507430
<daniel.bensoussan--bohm@etu.univ-lyon1.fr> writes:

>>The document starts with
>
>   >This document attempts to write down and motivate some of the
>   >workflow elements used for `git.git` itself.  Many ideas apply
>   >in general, though the full workflow is rarely required for
>   >smaller projects with fewer people involved.
>
>>and makes me wonder (note: I am not involved in writing any of the
>>existing text in this document) how much material foreign to the
>>actual workflow used for `git.git` should go in here.  Having
>>multiple maintainers at the same time is not a workflow element that
>>we have ever used, for example, so I am not sure about the change in
>>the above paragraph.
>
> We were told to change 'he' into 'they' to be neutral.  However, it's true
> that there's one maintainer at a time so we will remove the 's' from
> "maintainers". 

Not a native speaker, but according to wikipedia
(https://en.wikipedia.org/wiki/Singular_they) it's OK to write
"maintainer [singular, but already neulral] may get merge conflicts when
they [sinugular they] ..."

-- 
Matthieu Moy
https://matthieu-moy.fr/
