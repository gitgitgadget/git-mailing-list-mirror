X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add -v and --abbrev options to git-branch
Date: Fri, 24 Nov 2006 15:04:49 +0100
Organization: At home
Message-ID: <ek6u2s$at4$1@sea.gmane.org>
References: <1164375910450-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 24 Nov 2006 14:03:55 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 11
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32218>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnbee-0002gw-I8 for gcvg-git@gmane.org; Fri, 24 Nov
 2006 15:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934615AbWKXOD2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 09:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934618AbWKXOD2
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 09:03:28 -0500
Received: from main.gmane.org ([80.91.229.2]:20967 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S934615AbWKXOD2 (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 09:03:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GnbeG-0002bT-RN for git@vger.kernel.org; Fri, 24 Nov 2006 15:03:24 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 15:03:24 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 24 Nov 2006
 15:03:24 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Lars Hjemli wrote:

> The new -v option makes git-branch show the abbreviated sha1 + subjectline
> for each branch.

Isn't what git-show-ref is about? Or git-for-each-ref?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

