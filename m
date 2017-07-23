Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	TVD_SPACE_RATIO,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AFAD203F3
	for <e@80x24.org>; Sun, 23 Jul 2017 09:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751421AbdGWJoS (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 05:44:18 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.48]:15497 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750909AbdGWJoR (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Jul 2017 05:44:17 -0400
X-Greylist: delayed 1260 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Jul 2017 05:44:17 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 0E6E516FCE
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 04:23:15 -0500 (CDT)
Received: from mx26.hostgator.mx ([192.185.131.20])
        by cmsmtp with SMTP
        id ZD5td2q28dHTnZD5tdVbhG; Sun, 23 Jul 2017 04:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cinnergi.mx
        ; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:To:From:
        Message-Id:Subject:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=d9oKHONRNg6NPuC87dfEE9GlunipP5INY89ZROIjE+A=; b=i5aAsYrEuFts4190oSrVByEFlF
        /ED94vadyD9bf8jvdcGtnuzmnN1J4FCLuX3p01rN9nkM+DXU78+97MxK3NreRVc7NDQQdvxIUfzbU
        doAwQZeNbqXbGMKnAgVqHg3EdUcN2Gw77GsX8SsqaqAYUKovcz7dJAqGrceNgulW2PgaNc4BfCEMZ
        1FEqvzx5zvgcjjcXFWv4FNZZ+uDxC9BFTiiTW/DGsLdUEhj0ywYvVi3TJKKTiV+x5MkroQ5dhUILy
        10Z99JWsCUWi1b4V6ebSGDnPhITi7rB+QnFRWZrEcqXzH1kCwfsozZdpfY66EvCQc9pRhgdA6OVae
        b6Hr/qIg==;
Received: from [106.77.189.136] (port=64892 helo=cinnergi.mx)
        by mx26.hostgator.mx with esmtpa (Exim 4.87)
        (envelope-from <gsoto@cinnergi.mx>)
        id 1dZD6Y-000HCH-0u
        for git@vger.kernel.org; Sun, 23 Jul 2017 06:23:14 -0300
Date:   Sun, 23 Jul 2017 12:23:13 +0300
Subject: 
Message-Id: <dkqznydpmnhy16xahfthsqq4.15008017934286@email.android.com>
From:   "madhan_dc" <gsoto@cinnergi.mx>
To:     "git" <git@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mx26.hostgator.mx
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cinnergi.mx
X-BWhitelist: no
X-Source-IP: 106.77.189.136
X-Exim-ID: 1dZD6Y-000HCH-0u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (cinnergi.mx) [106.77.189.136]:64892
X-Source-Auth: gsoto@cinnergi.mx
X-Email-Count: 225
X-Source-Cap: Y2lubmVyZ2k7Y2lubmVyZ2k7bXgyNi5ob3N0Z2F0b3IubXg=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Z3JlZXRpbmdzIEdpdA0KDQoNCg0KaHR0cDovL3Jvb3R5dS5jbi91cGxvYWRfdmlkZW8ucGhwP25v
dGU9ZXgyYzdrenA0cno4NQ0KDQoNCg0KDQptYWRoYW5fZGM=

