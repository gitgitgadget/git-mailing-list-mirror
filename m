X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: svn versus git
Date: Thu, 14 Dec 2006 00:17:56 +0100
Organization: At home
Message-ID: <elq1ig$4ie$1@sea.gmane.org>
References: <200612132200.41420.andyparkins@gmail.com> <20061213225627.GC32568@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 13 Dec 2006 23:20:37 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 14
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34252>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GudOq-00009V-DB for gcvg-git@gmane.org; Thu, 14 Dec
 2006 00:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751731AbWLMXU3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 18:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbWLMXU3
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 18:20:29 -0500
Received: from main.gmane.org ([80.91.229.2]:58955 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751730AbWLMXU2
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 18:20:28 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GudOM-0005Hy-Ja for git@vger.kernel.org; Thu, 14 Dec 2006 00:20:02 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 00:20:02 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 14 Dec 2006
 00:20:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:

>   git cat-file -p $REV:$file
> 
> not sure how much easier it gets than that.  Load in the bash
> completion from contrib/completion and you can even tab complete
> the $file part.

Actually, tab completion allows to complete both $REV and $file part.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

