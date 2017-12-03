Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3395320C11
	for <e@80x24.org>; Sun,  3 Dec 2017 21:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752760AbdLCVUM (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 16:20:12 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:3673 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752757AbdLCVUL (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2017 16:20:11 -0500
X-IronPort-AV: E=Sophos;i="5.45,355,1508796000"; 
   d="scan'208";a="303755596"
Received: from orange.lip.ens-lyon.fr ([140.77.14.54])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-GCM-SHA256; 03 Dec 2017 22:20:07 +0100
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     Nathan PAYRE <second.payre@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ryan Anderson <ryan@michonline.com>,
        "e\@80x24.org" <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
        PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>,
        ALBERTIN TIMOTHEE p1514771 
        <timothee.albertin@etu.univ-lyon1.fr>,
        BENSOUSSAN--BOHM DANIEL p1507430 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Subject: Re: [PATCH] send-email: extract email-parsing code into a subroutine
References: <20171202170220.10073-1-second.payre@gmail.com>
        <445d0838cf2a4107bad95d5cc2d38a05@BPMBX2013-01.univ-lyon1.fr>
Date:   Sun, 03 Dec 2017 22:20:00 +0100
In-Reply-To: <445d0838cf2a4107bad95d5cc2d38a05@BPMBX2013-01.univ-lyon1.fr>
        (Nathan PAYRE's message of "Sat, 2 Dec 2017 17:11:45 +0000")
Message-ID: <q7h9zi6zpkzj.fsf@orange.lip.ens-lyon.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nathan PAYRE <second.payre@gmail.com> writes:

> I found a mistake in my signed-off-by, please replace
> <nathan.payre@etu.univ-lyon1.fr.> by <second.payre@gmail.com>

I think you want exactly the opposite of this. You're contributing as a
Lyon 1 student, hence your identity is @etu.univ-lyon1.fr. Your Gmail
adress is used only for technical reasons.

OTOH, you are missing the first line From: ... @..univ-lyon1.fr in your
message.

See how you did it:

https://public-inbox.org/git/20171012091727.30759-1-second.payre@gmail.com/

(The sign-off was wrong in this one, but the From was OK)

-- 
Matthieu Moy
https://matthieu-moy.fr/
