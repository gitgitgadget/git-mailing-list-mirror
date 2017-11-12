Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI,
	RCVD_NUMERIC_HELO,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AABF51F42B
	for <e@80x24.org>; Sun, 12 Nov 2017 11:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750860AbdKLLbT (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 06:31:19 -0500
Received: from cp-27.webhostbox.net ([208.91.198.76]:60497 "EHLO
        cp-27.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbdKLLbS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 06:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=unimetic.com; s=default; h=Message-ID:Subject:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a67+Xn2ScPIinix0jYfRqCmskGmMpaGSAycuaim21OI=; b=ND6nNjGF5fYdoYaOCGAUA4rmW
        skCPGceN6YV1JVUI0QG+IqgqE0JVumv+PFuSPBwzf/MHK0I3GFPTWJMWEhTFNaGcs2S2Ok0i2qp2v
        4oTz/Tf+bCshdyndWzHK73WUiVkNfn3pcTZ5c58aRAYe7PA34G5dC01DKErBV24oMu9UBVXa2kNDf
        Sfg3dr6iJnTP3PZbAKLZEU5cuy8zVBvDJYQToNZyQNVr2okNiT3sfczXlRJvs1/0usJlBGGIi7q8O
        +IS4MbgAis+pS6rbPt2lS2DQRI1YNRhaTS7Uf82guvLsDbfkMwBB70eeQWf5uKJ42xV5vJEnLT9gE
        TYiYOMW6w==;
Received: from [127.0.0.1] (port=51655 helo=208.91.198.76)
        by cp-27.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <hsed@unimetic.com>)
        id 1eDqTu-003UBx-Dt
        for git@vger.kernel.org; Sun, 12 Nov 2017 11:31:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 12 Nov 2017 11:31:18 +0000
From:   hsed@unimetic.com
To:     git@vger.kernel.org
Subject: 
Message-ID: <3c66bf7d408e22e49865323c65c313ee@unimetic.com>
X-Sender: hsed@unimetic.com
User-Agent: Roundcube Webmail/1.2.3
X-Authenticated_sender: hsed@unimetic.com
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp-27.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - unimetic.com
X-Get-Message-Sender-Via: cp-27.webhostbox.net: authenticated_id: hsed@unimetic.com
X-Authenticated-Sender: cp-27.webhostbox.net: hsed@unimetic.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

subscribe git
