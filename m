X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Patch to tutorial.txt
Date: Sun, 19 Nov 2006 23:59:13 +0100
Organization: At home
Message-ID: <ejqnh8$peb$1@sea.gmane.org>
References: <4d8e3fd30611191444r710f23e5uc488d35aa4abaf06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 19 Nov 2006 22:58:18 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 29
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31870>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glvbz-0005SH-5n for gcvg-git@gmane.org; Sun, 19 Nov
 2006 23:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933675AbWKSW6D (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 17:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933705AbWKSW6D
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 17:58:03 -0500
Received: from main.gmane.org ([80.91.229.2]:8686 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S933675AbWKSW6B (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 17:58:01 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Glvbm-0005Pb-Lc for git@vger.kernel.org; Sun, 19 Nov 2006 23:57:54 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 19 Nov 2006 23:57:54 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 19 Nov 2006
 23:57:54 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Paolo Ciarrocchi wrote:

> From 0b98769dfe16e3ba8cde698b75cb1067658c38e7 Mon Sep 17 00:00:00 2001

I think you should remove this line.

> From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
> Date: Sun, 19 Nov 2006 23:41:31 +0100
> Subject: [PATCH] One of the comment was not really clear, rephrased to
> make it easier to be understood by the reader

Wordwrap. Perhaps it would be better to split description into short line,
and two-line description.

[...]
>  ------------------------------------------------
> 
>  at this point the two branches have diverged, with different changes
> -made in each.  To merge the changes made in the two branches, run
> +made in each.  To merge the changes made in experimental into master run

I would rather say:
  To merge the changes made in the two branches into master, run

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

