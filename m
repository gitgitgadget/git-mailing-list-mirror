Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60214C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 10:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42C4720B80
	for <git@archiver.kernel.org>; Wed, 27 May 2020 10:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgE0KS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 06:18:28 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:32929 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgE0KS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 06:18:28 -0400
X-Originating-IP: 157.36.168.114
Received: from localhost (unknown [157.36.168.114])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 0926040008;
        Wed, 27 May 2020 10:18:25 +0000 (UTC)
Date:   Wed, 27 May 2020 15:48:20 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.27.0-rc2
Message-ID: <20200527101820.rprpjhtmkiu7gadg@yadavpratyush.com>
References: <xmqqtv02mt2m.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqtv02mt2m.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/05/20 11:47AM, Junio C Hamano wrote:
> A release candidate Git v2.27.0-rc2 is now available for testing
> at the usual places.  It is comprised of 509 non-merge commits
> since v2.26.0, contributed by 59 people, 17 of which are new faces.
> 
> Changes since v2.26.0 are as follows:
> 
> Ansgar Röber (1):
>       Subject: git-gui: fix syntax error because of missing semicolon

Looks like I messed up somewhere and left the "Subject: " in there. Its 
too late to do anything about it now I guess...

-- 
Regards,
Pratyush Yadav
