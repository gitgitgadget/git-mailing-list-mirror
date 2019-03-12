Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7319020248
	for <e@80x24.org>; Tue, 12 Mar 2019 13:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfCLNQJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 09:16:09 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:64462 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725957AbfCLNQJ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Mar 2019 09:16:09 -0400
X-IronPort-AV: E=Sophos;i="5.58,471,1544482800"; 
   d="scan'208";a="373054046"
Received: from wifi-ext-0085.univ-lyon1.fr (HELO moylip) ([134.214.214.86])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2019 14:16:07 +0100
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
Cc:     <git@vger.kernel.org>, <nathan.berbezier@etu.univ-lyon1.fr>,
        <pablo.chabanne@etu.univ-lyon1.fr>,
        "Eric Sunshine" <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2 v3] doc: format pathnames and URLs as monospace.
References: <20190306130446.2193-1-corentin.bompard@etu.univ-lyon1.fr>
        <20190306130446.2193-2-corentin.bompard@etu.univ-lyon1.fr>
Date:   Tue, 12 Mar 2019 14:16:06 +0100
In-Reply-To: <20190306130446.2193-2-corentin.bompard@etu.univ-lyon1.fr>
        (Corentin BOMPARD's message of "Wed, 6 Mar 2019 14:04:46 +0100")
Message-ID: <86va0o9qsp.fsf@matthieu-moy.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr> writes:

> Applying CodingGuidelines about monospace on pathnames and URLs.
>
> See Documentation/CodingGuidelines.txt for more information.
>
> Signed-off-by: Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
> Signed-off-by: Nathan BERBEZIER <nathan.berbezier@etu.univ-lyon1.fr>
> Signed-off-by: Pablo CHABANNE <pablo.chabanne@etu.univ-lyon1.fr>
> Signed-off-by: Matthieu MOY <matthieu.moy@univ-lyon1.fr>
> ---
>  Changes: We listen to Matthieu MOY and Eric SUNSHINE's remarks about
>  our mistakes on the last patch.

This addresses all my previous remarks, so this (patches 1 and 2) is now

Reviewed-by: Matthieu Moy <git@matthieu-moy.fr>

I'm Cc-ing Eric in case he has anything more to say.

-- 
Matthieu Moy
https://matthieu-moy.fr/
