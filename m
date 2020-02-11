Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58A8C35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 19:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05142465D
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 19:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbgBKTSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:18:46 -0500
Received: from mu.digital-domain.net ([108.61.197.113]:53164 "EHLO
        mu.digital-domain.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbgBKTSq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 14:18:46 -0500
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Feb 2020 14:18:45 EST
Received: from kappa.digital-domain.net (kappa.digital-domain.net [IPv6:2001:8b0:36c:cc91::ac])
        (authenticated bits=0)
        by mu.digital-domain.net (8.14.7/8.14.7) with ESMTP id 01BJ8r9R018794
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Feb 2020 19:08:53 GMT
Date:   Tue, 11 Feb 2020 19:08:52 +0000
From:   Andrew Clayton <andrew@digital-domain.net>
To:     Aleksey Midenkov <midenok@gmail.com>
Newsgroups: org.kernel.vger.git
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Git tedious verbosity
Message-ID: <20200211190852.722e5e10@kappa.digital-domain.net>
In-Reply-To: <CAF8BazCpFyr_tpayWVtbk7V2LAtXaVmEKTCRQbgLYg4AvmvLvQ@mail.gmail.com>
References: <CAHk66ftUsKU2+Uhy-a7V5QcRdO7ShcYUk28qz7WAm28wGFmPOg@mail.gmail.com>
        <CAF8BazCpFyr_tpayWVtbk7V2LAtXaVmEKTCRQbgLYg4AvmvLvQ@mail.gmail.com>
X-Newsreader: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 11 Feb 2020 17:19:53 +0300
Aleksey Midenkov <midenok@gmail.com> wrote:

> Or gc about garbage collection? Actually bad defaults is big problem
> developers undeservedly ignore. You can control everything but you
> have to switch hundreds of options, because software defaults are
> oriented on dumbest user. Let's overcome this bad tendency and satisfy
> smartest users, not the dumbest ones. Unix was always terse system
> which provided little to no output by default. Let's honor that good
> tradition and not submit to "Google-Got-It" virus.

I've been using Git for over ten years so hopefully I'm not the
*dumbest* user, but I still appreciate the various tips and hints Git
provides...

Don't really see what the problem with them is and it seems you can
quieten them if they really bother you that much...

Andrew
