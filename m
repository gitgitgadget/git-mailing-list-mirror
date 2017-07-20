Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F3811F600
	for <e@80x24.org>; Thu, 20 Jul 2017 17:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965333AbdGTRAR (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 13:00:17 -0400
Received: from [195.159.176.226] ([195.159.176.226]:57435 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S935667AbdGTRAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 13:00:16 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1dYEnz-00068a-8L
        for git@vger.kernel.org; Thu, 20 Jul 2017 19:00:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Leah Neukirchen <leah@vuxu.org>
Subject: Re: --interactive mode: readline support =?utf-8?B?4oyo4qyG?=
Date:   Thu, 20 Jul 2017 18:53:16 +0200
Message-ID: <874lu7nj7n.fsf@gmail.com>
References: <55629eef-537e-e5b6-c0dc-6e3372d00b33@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
In-Reply-To: <55629eef-537e-e5b6-c0dc-6e3372d00b33@gmx.net> (Marcel Partap's
        message of "Thu, 20 Jul 2017 10:21:18 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marcel Partap <mpartap@gmx.net> writes:

> Dear git devs,
> wouldn't it be great to have the power of readline added to the power
> of git interactive commands? Yes, rlwrap will do the job, but still.
> Or am I missing something obvious? Am using debian's 2.11.0-2 ...

Just use "rlwrap git clean -i".

-- 
Leah Neukirchen  <leah@vuxu.org>  http://leah.zone

