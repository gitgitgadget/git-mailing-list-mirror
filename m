X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Odd merge message in ad0c31?
Date: Tue, 28 Nov 2006 10:46:01 -0500
Message-ID: <20061128154601.GE28337@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 15:46:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32541>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp59w-0003Tf-DI for gcvg-git@gmane.org; Tue, 28 Nov
 2006 16:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935391AbWK1PqI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 10:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935389AbWK1PqI
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 10:46:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:22916 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S935391AbWK1PqF
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 10:46:05 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gp59h-0005CE-6n; Tue, 28 Nov 2006 10:45:57 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 7E75E20FB7F; Tue, 28 Nov 2006 10:46:01 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Is this because of my bash completion breakage?

commit ad0c31801b19d7614fac4c82fba67121b75bdea8
Merge: b3fccc6... 255cae8...
Author: Junio C Hamano <junkio@cox.net>
Date:   Mon Nov 27 17:14:31 2006 -0800

    Merge branch 'ap/clone-origin' of .git/ into next
                                   ^^^^^^^^
                                   ^^^^^^^^

or were you just doing something weird at that time?

-- 
