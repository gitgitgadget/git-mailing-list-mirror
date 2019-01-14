Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1101211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 17:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfANRxh (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 12:53:37 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:42997 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbfANRxh (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 14 Jan 2019 12:53:37 -0500
X-IronPort-AV: E=Sophos;i="5.56,478,1539640800"; 
   d="scan'208";a="364024553"
Received: from nautfst12.univ-lyon1.fr (HELO moylip) ([134.214.142.79])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2019 18:53:35 +0100
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     git@vger.kernel.org
Subject: Students projects: looking for small and medium project ideas
Date:   Mon, 14 Jan 2019 18:53:35 +0100
Message-ID: <86fttvcehs.fsf@matthieu-moy.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I haven't been active for a while on this list, but for those who don't
know me, I'm a CS teacher and I'm regularly offering my students to
contribute to open-source projects as part of their school projects. A
few nice features like "git rebase -i --exec" or many of the hints in
"git status" were implemented as part of these projects.

I'm starting another instance of such project next week.

Part of the work of students is to choose which feature they want to
work on, but I try to prepare this for them. I'm keeping a list of ideas
here:

  https://git.wiki.kernel.org/index.php/SmallProjectsIdeas

(At some point, I should probably migrate this to git.github.io, since
the wiki only seems half-alive these days).

I'm looking for small to medium size projects (typically, a GSoC project
is far too big in comparison, but we may expect more than just
microprojects).

You may suggest ideas by editting the wiki page, or just by replying to
this email (I'll point my students to the thread). Don't hesitate to
remove entries (or ask me to do so) on the wiki page if you think they
are not relevant anymore.

Thanks in advance,

-- 
Matthieu Moy
https://matthieu-moy.fr/
