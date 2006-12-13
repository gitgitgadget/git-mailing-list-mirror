X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: changing log entries
Date: Thu, 14 Dec 2006 00:22:17 +0100
Organization: At home
Message-ID: <elq1qk$4ie$2@sea.gmane.org>
References: <1166051281.1808.1.camel@jcm.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 13 Dec 2006 23:25:27 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 12
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34255>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GudTW-0000kt-GZ for gcvg-git@gmane.org; Thu, 14 Dec
 2006 00:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751742AbWLMXZT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 18:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbWLMXZT
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 18:25:19 -0500
Received: from main.gmane.org ([80.91.229.2]:48366 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751746AbWLMXZS
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 18:25:18 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GudTD-0006PP-6j for git@vger.kernel.org; Thu, 14 Dec 2006 00:25:03 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 00:25:03 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 14 Dec 2006
 00:25:03 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jon Masters wrote:

> Anyway, now I would like to change an existing log entry to make it a
> bit cleaner (read: add a first line that's under 80 characters). What's
> the best way to change an existing log entry for a commit?

See top two answers in http://git.or.cz/gitwiki/GitTips
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

