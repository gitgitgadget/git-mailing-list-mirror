Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6DA207FF
	for <e@80x24.org>; Fri,  5 May 2017 14:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753894AbdEEODE (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 10:03:04 -0400
Received: from [195.159.176.226] ([195.159.176.226]:60624 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1753847AbdEEODE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 10:03:04 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1d6dou-0000Sb-Dn
        for git@vger.kernel.org; Fri, 05 May 2017 16:02:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Harry Putnam <reader@newsguy.com>
Subject: How to `git status' without scrambling modified with new, etc
Date:   Fri, 05 May 2017 10:02:54 -0400
Organization: Still searching...
Message-ID: <86bmr7xuy9.fsf@local.lan>
Mime-Version: 1.0
Content-Type: text/plain
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.0.50 (gnu/linux)
Cancel-Lock: sha1:CY3m5Jf2U8XbCSjLRKvDk7fra/k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is probably what everyone sees:

When I run `git status'; I see  modified and newfiles scrambled together

Is there a trick or technique to make that output show each category
separately?

Or do folks just a throw a `sort' in there (git status|sort) and lose
the color ouput?

