Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AD6D1F404
	for <e@80x24.org>; Sun, 11 Feb 2018 18:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753642AbeBKSwk (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 13:52:40 -0500
Received: from parikesit.satu.rumahweb.com ([103.247.9.189]:55795 "EHLO
        parikesit.satu.rumahweb.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753619AbeBKSwk (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Feb 2018 13:52:40 -0500
X-Greylist: delayed 3577 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Feb 2018 13:52:39 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=anaufalm.com; s=default; h=Message-ID:Subject:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q9iiWEZ9JkypfhuK66OSbAHBMNANVnZi0Fnq78d7g5s=; b=fbZ+CgdOzEXR9qWicazOXaQex
        pqZMbBOgBZwW9uGgzo5Mekmi1okiuVcc3ya9jsnvOxdsAGaFruJl1wNCDpDLSLTj1Kn+JiQGNUWXW
        jXyLEkMty6jr6Q0dgVXEdRxov5c87f40UygfPCtQ86XMWcy8AF4XNU7wVrepkouaks115xTjRIdzf
        h08/Qi1SFNrUNUoRxMUU2xqqsNeD9zmEhNPnRHBNLALp5tq9VAZy1zrJ4LkmO7+NunXfSuh2jVmMw
        X9+rclsnsb+0R4L7MszHdbSFUMMxZJT436WEfyf83c3xhu0ksfLda1ktTCFX/LpaN43JfzwN7Qm0+
        tZhFPuOuw==;
Received: from [::1] (port=41460 helo=anaufalm.com)
        by parikesit.iixcp.rumahweb.com with esmtpa (Exim 4.89_1)
        (envelope-from <halo@anaufalm.com>)
        id 1ekvoC-0003Nx-FK
        for git@vger.kernel.org; Mon, 12 Feb 2018 00:53:00 +0700
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Feb 2018 00:53:00 +0700
From:   halo@anaufalm.com
To:     git@vger.kernel.org
Subject: REQUEST NEW TRANSLATION (INDONESIAN/id_ID)
Message-ID: <f5c147253f852d1243613a77e2c8d97b@anaufalm.com>
X-Sender: halo@anaufalm.com
User-Agent: Roundcube Webmail/1.3.3
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - parikesit.iixcp.rumahweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - anaufalm.com
X-Get-Message-Sender-Via: parikesit.iixcp.rumahweb.com: authenticated_id: halo@anaufalm.com
X-Authenticated-Sender: parikesit.iixcp.rumahweb.com: halo@anaufalm.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello git-l10n Team

I want to join to this project as a translator for Indonesian language 
(ID)
I have read the README file located in the 
https://github.com/git-l10n/git-po/blob/master/po/README directory

I also have a fork repository master (git-l10n) to my repository 
(anaufalm), and also I have edited the TEAMS file by adding my name as a 
translator for Indonesia (id). And also I created a new file `id.po` 
which I copy from file` ca.po` as the source. Because I not find 
original file as english, like `en.po`.

Furthermore, if approved, I will translate the file asap.

Thank you.

---

My repository (fork): https://github.com/anaufalm/git-id
PR link request TEAMS: https://github.com/git-l10n/git-po/pull/288
PR link add id.po file: https://github.com/git-l10n/git-po/pull/289
