X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to show log for only one branch
Date: Mon, 06 Nov 2006 16:25:24 +0100
Organization: At home
Message-ID: <eink3u$pmh$1@sea.gmane.org>
References: <454EAEDB.8020909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 6 Nov 2006 15:57:06 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 7
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31016>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh6dj-0004Fd-EP for gcvg-git@gmane.org; Mon, 06 Nov
 2006 16:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753121AbWKFPn4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 10:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753244AbWKFPn4
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 10:43:56 -0500
Received: from main.gmane.org ([80.91.229.2]:31203 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1753121AbWKFPnz (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 10:43:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gh6Wo-0002K7-T9 for git@vger.kernel.org; Mon, 06 Nov 2006 16:36:50 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 06 Nov 2006 16:36:50 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 06 Nov 2006
 16:36:50 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Perhaps what you want is git log --committer=<owner of repo>?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

