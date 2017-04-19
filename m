Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBD251FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 23:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968779AbdDSX5p (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 19:57:45 -0400
Received: from mout0.freenet.de ([195.4.92.90]:55483 "EHLO mout0.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968763AbdDSX5n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 19:57:43 -0400
Received: from [195.4.92.140] (helo=mjail0.freenet.de)
        by mout0.freenet.de with esmtpa (ID liebundartig@freenet.de) (port 25) (Exim 4.85 #1)
        id 1d0zTi-0000Fk-7i; Thu, 20 Apr 2017 01:57:42 +0200
Received: from localhost ([::1]:43063 helo=mjail0.freenet.de)
        by mjail0.freenet.de with esmtpa (ID liebundartig@freenet.de) (Exim 4.85 #1)
        id 1d0zTi-0007YT-3u; Thu, 20 Apr 2017 01:57:42 +0200
Received: from mx2.freenet.de ([195.4.92.12]:45951)
        by mjail0.freenet.de with esmtpa (ID liebundartig@freenet.de) (Exim 4.85 #1)
        id 1d0zQj-00057p-Ek; Thu, 20 Apr 2017 01:54:37 +0200
Received: from p20030045447e6e3990f8c675965ced16.dip0.t-ipconnect.de ([2003:45:447e:6e39:90f8:c675:965c:ed16]:36101)
        by mx2.freenet.de with esmtpsa (ID liebundartig@freenet.de) (TLSv1.2:DHE-RSA-AES128-SHA:128) (port 465) (Exim 4.85 #1)
        id 1d0zQj-0005if-87; Thu, 20 Apr 2017 01:54:37 +0200
Subject: Re: minor typos in documentation
To:     Stefan Beller <sbeller@google.com>
References: <ea2780fd-8d63-6060-fb17-df5720bbc3de@freenet.de>
 <CAGZ79kavV-58JyUce9BMO9S3LVKGeUBQU-Qt79LAR41xgr=MxA@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Genz?= <liebundartig@freenet.de>
Message-ID: <4f4e6b6e-7917-49c9-f4b4-627eaa062915@freenet.de>
Date:   Thu, 20 Apr 2017 01:54:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kavV-58JyUce9BMO9S3LVKGeUBQU-Qt79LAR41xgr=MxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Originated-At: 2003:45:447e:6e39:90f8:c675:965c:ed16!36101
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19.04.2017 22:55, Stefan Beller wrote:
...
>
> Thanks for spotting the errors!
>
> Care to craft a patch and send it upstream yourself?
> See https://github.com/git/git/blob/master/Documentation/SubmittingPatches
> how to approach it.
> TL;DR:
>     git clone https://github.com/git/git
>     # hack hack hack
>     git commit
>     git format-patch HEAD^
>     # use e.g. git send-email to send the patch to the mailing list
>
> Thanks,
> Stefan
>
>

To be honest I started to read the mentioned website, was intimidated and decided to sent an email.

Alright, what could possibly go wrong? I will do it.
-- 
Kind regards,
René
