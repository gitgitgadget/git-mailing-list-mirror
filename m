Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9217C34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 15:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A73222D9
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 15:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgBQPuU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:50:20 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:45527 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgBQPuU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 10:50:20 -0500
X-Originating-IP: 103.227.99.108
Received: from localhost (unknown [103.227.99.108])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 4AF18C0004;
        Mon, 17 Feb 2020 15:50:17 +0000 (UTC)
Date:   Mon, 17 Feb 2020 21:20:14 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Christian Stimming via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Stimming <christian@cstimming.de>
Subject: Re: [PATCH v2 0/3] git gui: improve German translation
Message-ID: <20200217155014.kytkqym7xpfdzatd@yadavpratyush.com>
References: <pull.525.git.1579905218.gitgitgadget@gmail.com>
 <pull.525.v2.git.1581285658.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.525.v2.git.1581285658.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On 09/02/20 10:00PM, Christian Stimming via GitGitGadget wrote:
> git-gui: update/improve German translation
> 
> Update translation template and translation glossary as prerequisite. Then,
> update German translation (glossary and final translation) to recent source
> code changes, but also switch several terms from uncommon translations back
> to English vocabulary, similar to the rest of git-core.
> 
> This most prominently concerns "commit" (noun, verb), "repository",
> "branch", and some more. These uncommon translations have been introduced
> long ago and never been changed since. In fact, the whole German translation
> here hasn't been touched for a long time. However, in German literature and
> magazines, git-gui is regularly noted for its uncommon choice of translated
> vocabulary. This somewhat distracts from the actual benefits of this tool.
> So it is probably better to abandon the uncommon translations and rather
> stick to the common English vocabulary in git version control.
> 
> The glossary is adapted to the git-core glossary at
> https://github.com/ruester/git-po-de/wiki/Translation-Guidelinesand the
> changed and updated terms are used in the actual translation accordingly.

Sorry for the late reply. Merged. Thanks.

-- 
Regards,
Pratyush Yadav
