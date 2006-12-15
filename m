X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [DRAFT 2] Branching and merging with git
Date: Fri, 15 Dec 2006 22:38:05 +0100
Organization: At home
Message-ID: <elv4f5$kcj$1@sea.gmane.org>
References: <7vslghftix.fsf@assigned-by-dhcp.cox.net> <20061120235136.4841.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 15 Dec 2006 21:36:14 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 16
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34553>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvKiy-00042e-6e for gcvg-git@gmane.org; Fri, 15 Dec
 2006 22:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753444AbWLOVgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 16:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753445AbWLOVgI
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 16:36:08 -0500
Received: from main.gmane.org ([80.91.229.2]:47868 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1753444AbWLOVgH
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 16:36:07 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GvKic-0006G7-5Z for git@vger.kernel.org; Fri, 15 Dec 2006 22:35:50 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 22:35:50 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 22:35:50 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

linux@horizon.com wrote:

> I tried to incorporate all the suggestions.  There are still a few things
> I have to research, and now I'm worried it's getting too long.  Sigh.

Tutorials can (and usually are) be long, don't worry.
 

Could you resend this as patch creating Documentation/tutorial-3.txt
This way it would be in the repository, and people would be able to correct
this (I guess that it at first would appear in 'next' branch)...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

