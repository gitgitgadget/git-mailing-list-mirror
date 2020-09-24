Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8BCC4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 14:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0876221EB
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 14:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgIXOVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 10:21:10 -0400
Received: from static.214.254.202.116.clients.your-server.de ([116.202.254.214]:47278
        "EHLO ciao.gmane.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbgIXOVK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 10:21:10 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 10:21:10 EDT
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcvg-git-3@m.gmane-mx.org>)
        id 1kLS2Z-0009Eb-Me
        for git@vger.kernel.org; Thu, 24 Sep 2020 16:16:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Yuri D'Elia <wavexx@thregr.org>
Subject: [ANNOUNCE] git-assembler 1.2 released
Date:   Thu, 24 Sep 2020 16:15:59 +0200
Message-ID: <87mu1f2rc0.fsf@wavexx.thregr.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Cancel-Lock: sha1:Qk2MRy74zkg+jzJZ60dpSaD0DxE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Announcing the release of version 1.2 of git-assembler. Among several
bug fixes since the initial announcement, this version strengthens
support for worktrees.

git-assembler can perform automatic merge and rebase operations
following a simple declarative script. Like "make", but for branches.
You can use git-assembler to create a branch which is a combination of
patches and keep it always updated.

Documentation and links are available at:

  https://www.thregr.org/~wavexx/software/git-assembler/

The source itself:

  https://gitlab.com/wavexx/git-assembler

Enjoy

