Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AF3C433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 13:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiGJNAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 09:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiGJNAe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 09:00:34 -0400
Received: from mariecurie.labrat.space (mariecurie.labrat.space [116.203.185.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECB77658
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 06:00:33 -0700 (PDT)
Received: from labrat.space (adsl-178-38-36-59.adslplus.ch [178.38.36.59])
        by mariecurie.labrat.space (Postfix) with ESMTPSA id E0D703B42B86
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 15:00:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=labrat.space;
        s=201904; t=1657458030;
        bh=c3mSMTAPfVCK3CN7beKf4x+nCdbH+dzpO5JrEAILoF0=;
        h=Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:From:To:CC:Date:
         Subject:Content-Type:Content-Disposition:Reply-To:In-Reply-To:
         MIME-Version:Message-ID:References;
        b=GJr2xjYde9bKjviFOucuUHRe1pq1fuQPx6AlTOv8bFW4dAVXZZ1+z4c7yBoG75RlM
         eRpBFVS7WEyT3xCuuTEM6tgpZ7ueMDFSYibaooji8+pfNiVr+IBNNUd3Jr2OpHMzlC
         5xkyM9TH2F0IOHz3tHNt7JjooNcvperd35UFsDFU7+SpthLvVmwYTOvvynTZkCwZm8
         0TopvrcQbvoZVbMJWOGLiBH1LceQW3jc/xvhbS1hXlMVKPP+2vn2CSiUgC9dPx0VqA
         eOgFUAbIu2iCnwrTf104kHBtWkr2Gph+4f68xJhiGb74GhQ/z0qIHW+9ablvd6GOzt
         2JdeigU3EWUqg==
Date:   Sun, 10 Jul 2022 15:00:27 +0200
From:   Reto <reto@labrat.space>
To:     git@vger.kernel.org
Subject: Re: Suggestion to rename "blame" of the "git blame" command to
 something more neutral
Message-ID: <20220710130027.fsjd5m7s7swc4zxc@feather>
Mail-Followup-To: git@vger.kernel.org
References: <CADS2hGpnkiPzivVDyN-PnGsQCTafqx68PxigXvBK1bv4O=p4kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADS2hGpnkiPzivVDyN-PnGsQCTafqx68PxigXvBK1bv4O=p4kg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I like blame... Some humour when using tools is appreciated.
After all, chances are that the idiot who wrote the code was past-you
anyhow :P

Also pretty easy to remember, annotated doesn't exactly strike me as
memorable.
