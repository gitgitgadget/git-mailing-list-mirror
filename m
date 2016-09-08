Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00B021F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 06:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756626AbcIHGf3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 02:35:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42023 "EHLO mx1.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752396AbcIHGf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 02:35:28 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u886ZJtd002759
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 8 Sep 2016 08:35:19 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u886ZJu0015933;
        Thu, 8 Sep 2016 08:35:19 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 3/5] git-rebase--interactive: fix English grammar
References: <20160908043417.5946-1-alexhenrie24@gmail.com>
Date:   Thu, 08 Sep 2016 08:35:19 +0200
In-Reply-To: <20160908043417.5946-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Wed, 7 Sep 2016 22:34:17 -0600")
Message-ID: <vpqeg4uaogo.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 08 Sep 2016 08:35:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u886ZJtd002759
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1473921321.74617@FhjS8DxQ/oG9nOteVhzRyA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -1082,7 +1082,7 @@ If they are meant to go into a new commit, run:
>  
>    git commit \$gpg_sign_opt_quoted
>  
> -In both case, once you're done, continue with:
> +In both cases, once you're done, continue with:

I don't remember writing this, but since I'm Cc-ed I guess I did ;-).

Obviously correct, thanks.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
