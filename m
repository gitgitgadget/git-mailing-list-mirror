Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C0421FF7F
	for <e@80x24.org>; Sat, 10 Dec 2016 20:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbcLJU2a (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 15:28:30 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:36102 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbcLJU23 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 15:28:29 -0500
Received: from PhilipOakley ([92.22.22.210])
        by smtp.talktalk.net with SMTP
        id FoFuc6HYmgKstFoFucLAu2; Sat, 10 Dec 2016 20:28:27 +0000
X-Originating-IP: [92.22.22.210]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=ml+yzTU89BnYyX12/wy+jA==:117
 a=ml+yzTU89BnYyX12/wy+jA==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=Z8y99KKd0XAkE2ex-9sA:9 a=wPNLvfGTeEIA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <88A192B34B3D4DDDA47628687AE458D3@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Kristoffer Haugsbakk" <kristoffer.haugsbakk@gmail.com>,
        <git@vger.kernel.org>
Cc:     "Kristoffer Haugsbakk" <kristoffer.haugsbakk@gmail.com>
References: <20161209155112.2112-1-kristoffer.haugsbakk@gmail.com> <20161209155112.2112-2-kristoffer.haugsbakk@gmail.com>
Subject: Re: [PATCH 1/4] doc: add articles (grammar)
Date:   Sat, 10 Dec 2016 20:28:27 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfAm7/xrjVyMD2CrzF+oin1NEjMoImhdzjXt0WFD82WEAmZdIDk18bB8HH2HlKy+VoLuXUikl06YdlzFrQSHE9ktdCXNTq4l9y77dzEDyuL2iHdeZRDbh
 vK2XIGdPChemI5GH1GtJ3a/uLgEAF7bfbym1u6oJSr74JmznSwhSJhJYu7qQgdHTrPpOI8JQfRMQ6u7IAwVbaDkGcGeKAuz+32NvzwI8il6amOPVIUBxf5l/
 BAuign+ylhtzC09S5NFIuw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Kristoffer Haugsbakk" <kristoffer.haugsbakk@gmail.com>
Sent: Friday, December 09, 2016 3:51 PM
> Add definite and indefinite articles in three places where they were
> missing.
>
> - Use "the" in front of a directory name
> - Use "the" in front of "style of cooperation"
> - Use an indefinite article in front of "CVS background"
>
> Signed-off-by: Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
> ---
> Documentation/gitcore-tutorial.txt | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/gitcore-tutorial.txt 
> b/Documentation/gitcore-tutorial.txt
> index 4546fa0d7..6c434aff3 100644
> --- a/Documentation/gitcore-tutorial.txt
> +++ b/Documentation/gitcore-tutorial.txt
> @@ -1368,7 +1368,7 @@ $ git repack
> will do it for you. If you followed the tutorial examples, you
> would have accumulated about 17 objects in `.git/objects/??/`
> directories by now. 'git repack' tells you how many objects it
> -packed, and stores the packed file in `.git/objects/pack`
> +packed, and stores the packed file in the `.git/objects/pack`
> directory.
>
> [NOTE]
> @@ -1543,9 +1543,9 @@ like this:
> Working with Others, Shared Repository Style
> --------------------------------------------
>
> -If you are coming from CVS background, the style of cooperation
> +If you are coming from a CVS background, the style of cooperation
> suggested in the previous section may be new to you. You do not
> -have to worry. Git supports "shared public repository" style of
> +have to worry. Git supports the "shared public repository" style of
> cooperation you are probably more familiar with as well.
>
> See linkgit:gitcvs-migration[7] for the details.
> -- 
> 2.11.0

This looks good to me.
--
Philip (UK) 

