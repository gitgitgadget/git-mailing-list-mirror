X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: git-merge-recursive-old?
Date: 29 Nov 2006 06:57:36 -0800
Message-ID: <868xhuxpun.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 29 Nov 2006 14:58:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.15.6; tzolkin = 13 Cimi; haab = 19 Ceh
Original-Lines: 9
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32640>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpQsa-0003bd-8N for gcvg-git@gmane.org; Wed, 29 Nov
 2006 15:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967352AbWK2O5k (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 09:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967375AbWK2O5k
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 09:57:40 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:6427 "EHLO
 blue.stonehenge.com") by vger.kernel.org with ESMTP id S967352AbWK2O5k (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 09:57:40 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id 8F61C8F9EF for <git@vger.kernel.org>; Wed, 29 Nov
 2006 06:57:39 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 30089-01-69 for <git@vger.kernel.org>; Wed, 29 Nov 2006 06:57:37 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 1F82B8FB7E;
 Wed, 29 Nov 2006 06:57:37 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


I build daily, and apaprently I built git-merge-recursive-old,
but it's not in .gitignore.  Needs to be added, no?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
