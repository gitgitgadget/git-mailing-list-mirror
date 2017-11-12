Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI,
	RCVD_NUMERIC_HELO,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C2711F43C
	for <e@80x24.org>; Sun, 12 Nov 2017 03:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbdKLDDN (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 22:03:13 -0500
Received: from cp-27.webhostbox.net ([208.91.198.76]:36689 "EHLO
        cp-27.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752502AbdKLDDM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 22:03:12 -0500
X-Greylist: delayed 2526 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Nov 2017 22:03:12 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=unimetic.com; s=default; h=Message-ID:Subject:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a67+Xn2ScPIinix0jYfRqCmskGmMpaGSAycuaim21OI=; b=LIu8KB9Fl7qGsGHsNpKN9cAip
        8p93qq7KMh2tTKnCnvA53LXaeOzta5w9HhvvtazPGUEED8+tBb/eyensZLpLCjYXIjHtMQAmfcq2k
        htCwutKMe+P8zeRTgSHXCqtFgUu1BA7JgB0sdpwv6IUFx1TAXSRQWHpGydev21D3MqjkS7vmxXLf5
        Ow/sYeYvsd4CzymEN0ZPlKezkcvNob+GwmBVrDAJNmSZ0GjFD++Px+WkeyflL49L00ViSilgPqRoR
        swduV5habx07CItgKJrILf+FKwC+Tev7DsJyAEKuHYFoVuH8qx9DKdIYiRYhLxR/ohjXe9uy9f8ip
        TBIW7Xg3Q==;
Received: from [127.0.0.1] (port=36783 helo=208.91.198.76)
        by cp-27.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <hsed@unimetic.com>)
        id 1eDhtS-003mu6-C3
        for git@vger.kernel.org; Sun, 12 Nov 2017 02:21:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 12 Nov 2017 02:21:06 +0000
From:   hsed@unimetic.com
To:     git@vger.kernel.org
Subject: 
Message-ID: <230e768792941861fca03ec4f3422541@unimetic.com>
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
