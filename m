Return-Path: <SRS0=1Io1=D7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_40,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1CDC2D0A3
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 21:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91EF7208B3
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 21:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764526AbgJXVjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 17:39:36 -0400
Received: from crypt.org ([89.187.75.214]:42214 "EHLO crypt.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764478AbgJXVjg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 17:39:36 -0400
X-Greylist: delayed 1520 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Oct 2020 17:39:36 EDT
Received: from crypt.org (crypt.org [127.0.0.1])
        by crypt.org (8.11.6/8.11.2) with ESMTP id 09OKLPP13264;
        Sat, 24 Oct 2020 21:21:25 +0100
Message-Id: <202010242021.09OKLPP13264@crypt.org>
To:     hv@crypt.org
cc:     git@vger.kernel.org
Subject: Re: safer git? 
In-Reply-To: <202010242019.09OKJTP13180@crypt.org> 
Date:   Sat, 24 Oct 2020 21:21:25 +0100
From:   hv@crypt.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, I should have added: I'm using Ubuntu 18.04.5 (bionic) with
git version 2.17.1.

Hugo
