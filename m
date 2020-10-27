Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFCCC55179
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 17:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3C321D42
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 17:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783212AbgJ0O57 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 10:57:59 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:20466 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1783148AbgJ0O56 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 10:57:58 -0400
Received: from [IPv6:2a01:e0a:d1:f360:1d6a:adae:aa81:b648] (unknown [IPv6:2a01:e0a:d1:f360:1d6a:adae:aa81:b648])
        (Authenticated sender: jn.avila)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 92CFFB0056B;
        Tue, 27 Oct 2020 15:57:53 +0100 (CET)
Subject: Re: [PATCH] l10n: fr.po Fix a typo
To:     Baptiste Fontaine <b@ptistefontaine.fr>, git@vger.kernel.org
References: <20201027120611.5084-1-b@ptistefontaine.fr>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Message-ID: <b01a6900-b26f-2bf1-c091-85f162c5ffa4@free.fr>
Date:   Tue, 27 Oct 2020 15:57:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027120611.5084-1-b@ptistefontaine.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 27/10/2020 à 13:06, Baptiste Fontaine a écrit :
> Signed-off-by: Baptiste Fontaine <b@ptistefontaine.fr>
> ---
>  po/fr.po | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git po/fr.po po/fr.po
> index f510f0bc6f..b1cbaca24d 100644
> --- po/fr.po
> +++ po/fr.po
> @@ -8282,7 +8282,7 @@ msgstr ""
>  #: sha1-name.c:1717
>  #, c-format
>  msgid "path '%s' does not exist in '%.*s'"
> -msgstr "le chemin '%s' n'existe pas dnas '%.*s'"
> +msgstr "le chemin '%s' n'existe pas dans '%.*s'"
>  
>  #: sha1-name.c:1745
>  #, c-format


Queued.


Thank you very much.


Jean-Noël

