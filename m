Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BA692022A
	for <e@80x24.org>; Tue,  8 Nov 2016 00:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbcKHAyQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 19:54:16 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:46624 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbcKHAyP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 19:54:15 -0500
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1c3ug2-0003UG-96; Tue, 08 Nov 2016 00:54:14 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22561.8757.914542.10409@chiark.greenend.org.uk>
Date:   Tue, 8 Nov 2016 00:54:13 +0000
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/6] Provide for config to specify tags not to abbreviate
In-Reply-To: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
References: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ian Jackson writes ("[PATCH 0/6] Provide for config to specify tags not to abbreviate"):
> Please find in the following mails patches which provide a way to make
> gitk display certain tags in full, even if they would normally be
> abbreviated.
> 
> There are four patches to gitk, three to prepare the ground, and one
> to introduce the new feature.
>
> There is one patch for git, to just document the new config variable.

The eagle-eyed reader will spot that that makes 5 patches, not 6.
There are indeed only 5.  The subject mentioning 6 is a mistake -
sorry.

Thanks,
Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.
