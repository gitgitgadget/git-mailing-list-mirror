Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,STOX_REPLY_TYPE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA02F2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 16:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965777AbcJ1QcC (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 12:32:02 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:16403 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937846AbcJ1QcB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 12:32:01 -0400
Received: from PhilipOakley ([92.22.74.108])
        by smtp.talktalk.net with SMTP
        id 0A4Tc6zL0gKst0A4Ucr5Sg; Fri, 28 Oct 2016 17:31:58 +0100
X-Originating-IP: [92.22.74.108]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=gemZZafLxLrjWEucDwrW+g==:117
 a=gemZZafLxLrjWEucDwrW+g==:17 a=8nJEP1OIZ-IA:10 a=uX5db24ySTMTWYjb_kIA:9
 a=wPNLvfGTeEIA:10
Message-ID: <27B37F6A6F2946CEB274CC85CB43B1F2@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "David Lang" <david@lang.hm>, "John Rood" <mr.john.rood@gmail.com>
Cc:     "Stefan Beller" <sbeller@google.com>,
        "Git List" <git@vger.kernel.org>
References: <CALj-rGeoT_mpmuw8Put=6eRhzf-r2WUohu_Kd-wnpc=BvO5joA@mail.gmail.com> <CAGZ79ka7BvaW2pkjeXe68yKHFq6JsH__x2cXoe6U4tRmZ0rY1A@mail.gmail.com> <CALj-rGfAyimf0nFFcDHVHUgj8PQaz6Cvoz_PQfqdhr=QJEpbRw@mail.gmail.com> <alpine.DEB.2.02.1610271623260.4123@nftneq.ynat.uz>
Subject: Re: feature request
Date:   Fri, 28 Oct 2016 13:54:59 +0100
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
X-CMAE-Envelope: MS4wfOLRYaH5+uLQLwd1BxCoJdV2k5PwUImqeATGOOTyM4pCcAxk3ikGP2tF9r2YFhOhEzv9IE+3lfda1uOSZcCq5L719I5ArNkovRX9bX37Pzi4Vg2Ffh0Q
 j/4P0dQLDillNQ66MG+FzMZHCK0+EmoF3CdE+oD/JuUomXkv8Fj4SvzEtt84hlCYW66wekuvk8gas/RbhjK9siVWghd2EdsDmuk+6zntz09ZZbtQDlDIh9RT
 tmPhuw4Jd4AXlAzW0iCh/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "David Lang" <david@lang.hm>
> On Thu, 27 Oct 2016, John Rood wrote:
>
>> Thanks, I think changing the default for windows is a good idea.
>
> notepad doesn't work well with unix line endings, wordpad handles the 
> files much more cleanly.
>
> David Lang
>

Notepad++ does work well, but isn't a standard part of Windows.

[core]
 editor = 'C:/Program 
Files/Notepad++/notepad++.exe' -multiInst -notabbar -nosession -noplugin

.. is one of the standard StackOverflow recipes.
--
Philip 

