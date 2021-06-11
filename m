Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D97EC48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 15:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24FD560D07
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 15:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhFKPpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 11:45:45 -0400
Received: from vps.thesusis.net ([34.202.238.73]:55402 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhFKPpo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 11:45:44 -0400
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id DF9CA301BD; Fri, 11 Jun 2021 11:43:15 -0400 (EDT)
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
 <60be91757c6ca_db80d2086e@natae.notmuch> <87czsu98ar.fsf@vps.thesusis.net>
 <60c123edcae35_aa2ee20886@natae.notmuch>
User-agent: mu4e 1.5.13; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
Date:   Fri, 11 Jun 2021 11:40:39 -0400
In-reply-to: <60c123edcae35_aa2ee20886@natae.notmuch>
Message-ID: <87lf7g76gc.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Felipe Contreras <felipe.contreras@gmail.com> writes:

> This is a good use of singular they:
>
>   Everyone returned to their seats

Shouldn't seat be singular there so that it agrees in number with the
singular their?

