Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05327C43334
	for <git@archiver.kernel.org>; Sun, 17 Jul 2022 13:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiGQNhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jul 2022 09:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGQNhB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jul 2022 09:37:01 -0400
Received: from omta012.uswest2.a.cloudfilter.net (omta012.uswest2.a.cloudfilter.net [35.164.127.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839E912D2A
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 06:37:00 -0700 (PDT)
Received: from cxr.smtp.a.cloudfilter.net ([10.0.17.148])
        by cmsmtp with ESMTP
        id D2mCopKUKFZt0D4SBoPXJ7; Sun, 17 Jul 2022 13:37:00 +0000
Received: from thunderbird.smith.home ([68.231.83.103])
        by cmsmtp with ESMTPSA
        id D4SAo2b0hqzBCD4SBo9FyH; Sun, 17 Jul 2022 13:36:59 +0000
Authentication-Results: cox.net; auth=pass (PLAIN) smtp.auth=ischis2@cox.net
X-Authority-Analysis: v=2.4 cv=P9ApOwMu c=1 sm=1 tr=0 ts=62d4107b
 a=5LiH+hCkRbbaxi2S5Ofzgw==:117 a=5LiH+hCkRbbaxi2S5Ofzgw==:17
 a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=OiUnmQINgBxGPQu4R14A:9
 a=CjuIK1q_8ugA:10 a=QYH75iMubAgA:10
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 6C3391961FFD;
        Sun, 17 Jul 2022 06:36:58 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Branch next doesn't look like it was pushed
Date:   Sun, 17 Jul 2022 06:36:58 -0700
Message-ID: <2680398.mvXUDI8C0e@thunderbird>
In-Reply-To: <xmqqr12kwxhs.fsf@gitster.g>
References: <12032556.O9o76ZdvQC@thunderbird> <xmqqr12kwxhs.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CMAE-Envelope: MS4xfD2RotfbZ+l9xeI4PxDkVHb28RDb+DOhjfthEIbB9zy5ysn6ZwcVDayWGXCY3CDjSTZmhpKhjaLY/olOCuHxaCKKeVz3b2kShvMXzkpOP2ajEq1r80Jo
 tCCZZhFltfxOW6m54VVPYCozgo9q6hfZJzCFF9lYXKKuYtkss5PTLt4RJMWvTue118Y43RPRFMV0+M2Q5A0i9bOr63Y/hrC4qZFE3StUKH2ypZ3LCIN4ttfH
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Saturday, July 16, 2022 2:36:47 PM MST Junio C Hamano wrote:
> The 'next' branch is designed to be always
> a descendant of 'master', unless I screw up, and I'd appreciate if
> you let me know when it happens.  Right now, it is not the case,
> though.

I thought it had been, but you are right.    Sorry.


