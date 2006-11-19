X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git manuals
Date: Sun, 19 Nov 2006 19:16:13 +0100
Organization: At home
Message-ID: <ejq6ul$7co$1@sea.gmane.org>
References: <20061116221701.4499.qmail@science.horizon.com> <20061117153246.GA20065@thunk.org> <20061117182157.GC11882@fieldses.org> <20061119175040.GB15608@fieldses.org> <20061119175952.GX7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 19 Nov 2006 18:15:00 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 15
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31848>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlrBv-0006an-Q8 for gcvg-git@gmane.org; Sun, 19 Nov
 2006 19:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932673AbWKSSOx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 13:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbWKSSOx
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 13:14:53 -0500
Received: from main.gmane.org ([80.91.229.2]:61100 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S932673AbWKSSOw (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 13:14:52 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GlrBq-0006Zc-HF for git@vger.kernel.org; Sun, 19 Nov 2006 19:14:50 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 19 Nov 2006 19:14:50 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 19 Nov 2006
 19:14:50 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Petr Baudis wrote:

> Your approach is fine for something you would call "Git Reference
> Manual", but it is something really different from "The Git Book" or
> "Git User's Manual".

By the way, does AsciiDoc support conversion to texinfo (and then to info)
format? It would be nice to have "The Git Book" aka "GUM - Git User's
Manual" in texinfo, HTML and perhaps also PDF (HTML and PDF with
graphs/images).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

