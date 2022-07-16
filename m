Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46457C43334
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 14:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiGPOlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 10:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGPOlv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 10:41:51 -0400
Received: from omta014.uswest2.a.cloudfilter.net (omta014.uswest2.a.cloudfilter.net [35.164.127.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78675305
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 07:41:50 -0700 (PDT)
Received: from cxr.smtp.a.cloudfilter.net ([10.0.16.145])
        by cmsmtp with ESMTP
        id Cdo7o5RWU5wbRCizOoYwR3; Sat, 16 Jul 2022 14:41:50 +0000
Received: from thunderbird.smith.home ([68.231.83.103])
        by cmsmtp with ESMTPSA
        id CizLovRkgElOVCizNoolYP; Sat, 16 Jul 2022 14:41:50 +0000
Authentication-Results: cox.net; auth=pass (PLAIN) smtp.auth=ischis2@cox.net
X-Authority-Analysis: v=2.4 cv=HoplpmfS c=1 sm=1 tr=0 ts=62d2ce2e
 a=5LiH+hCkRbbaxi2S5Ofzgw==:117 a=5LiH+hCkRbbaxi2S5Ofzgw==:17
 a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=NZ2X0M2xPq_r7PyrnoUA:9 a=CjuIK1q_8ugA:10
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 515101961F19;
        Sat, 16 Jul 2022 07:41:47 -0700 (MST)
From:   Stephen Smith <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Branch next doesn't look like it was pushed
Date:   Sat, 16 Jul 2022 07:41:47 -0700
Message-ID: <12032556.O9o76ZdvQC@thunderbird>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CMAE-Envelope: MS4xfIF2gdPcz3Pu9qLEHMIpCLah9nawZqvu5SnzWjeLe3WOQq/wSYAjRVO17TPRtmJAZeUN2Nha2BjVN/ZF7Ex/RXlFJIDEF6zmj+MJUsKBYd6SGfQoluox
 hV5xy0F2oQMTDuuZCePWaLRF/tcri/46rjaCCSB3kz0BazaWE3I7iJUNT97rXQgeEALr1EzbSDgZipKHvaIktlcmQYPQNoW9syZeZIor4lyfwDfH2rOGXnHK
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there a reason that with the latest commits to the repository that next is 
no longer an ancestor of seen  and than main/master is no longer an ancestor 
of next?




