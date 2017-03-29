Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FD9520958
	for <e@80x24.org>; Wed, 29 Mar 2017 12:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932617AbdC2MzE (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 08:55:04 -0400
Received: from mylo.jdl.com ([208.123.73.151]:58645 "EHLO mylo.jdl.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932523AbdC2MzD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 08:55:03 -0400
Received: from jdl (helo=mylo)
        by mylo.jdl.com with local-esmtp (Exim 4.82)
        (envelope-from <jdl@jdl.com>)
        id 1ctD7t-00015R-9G; Wed, 29 Mar 2017 07:55:01 -0500
From:   Jon Loeliger <jdl@jdl.com>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [RFC] should these two topics graduate to 'master' soon?
In-reply-to: <xmqqshlxckr2.fsf@gitster.mtv.corp.google.com>
References: <xmqqshlxckr2.fsf@gitster.mtv.corp.google.com>
Comments: In-reply-to Junio C Hamano <gitster@pobox.com>
   message dated "Tue, 28 Mar 2017 11:35:29 -0700."
Date:   Wed, 29 Mar 2017 07:55:01 -0500
Message-Id: <E1ctD7t-00015R-9G@mylo.jdl.com>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: jdl@jdl.com
X-SA-Exim-Scanned: No (on mylo.jdl.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So, like, Junio C Hamano said:
> There are two topics that are marked as "Will cook in 'next'" for
> practically forever in the "What's cooking" reports.  The world may
> have become ready for one or both of them, in which case we should
> do the merge not too late in the cycle.
> 
> * jc/merge-drop-old-syntax (2015-04-29) 1 commit
> 
> 
> * jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
> 
> Opinions?

While I have no technical data on these issues, I think
they should go in.

jdl
