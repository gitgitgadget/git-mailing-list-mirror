Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6929F20196
	for <e@80x24.org>; Tue,  9 May 2017 19:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbdEITmi (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 15:42:38 -0400
Received: from [195.159.176.226] ([195.159.176.226]:46473 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbdEITmh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 15:42:37 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1d8B1h-0003zJ-LJ
        for git@vger.kernel.org; Tue, 09 May 2017 21:42:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Harry Putnam <reader@newsguy.com>
Subject: Re: How to `git status' without scrambling modified with new, etc
Date:   Tue, 09 May 2017 15:42:28 -0400
Organization: Still searching...
Message-ID: <86k25pkeaj.fsf@local.lan>
References: <86bmr7xuy9.fsf@local.lan>
        <CACBZZX7Q36rFiO9SwBCzM2M3ae=vOPJ2dfaVQ6=geZLgkLAuWA@mail.gmail.com>
        <CAJZjrdVSX_HB0O_eiQk6bg_UF0=71PNVa1rBwSbpHFCbOrpAOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.0.50 (gnu/linux)
Cancel-Lock: sha1:GIadKOB7NdbODXhpWaG76uduapU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> You can use `git status -s` and match on the modification type (M
> corresponds to modified, A to new files). See the man page for more
> details on the interface.

ahh yes.  Just the ticket thanks

