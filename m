X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: jgit performance update
Date: Sun, 03 Dec 2006 18:56:33 +0100
Organization: At home
Message-ID: <ekv34g$mck$1@sea.gmane.org>
References: <20061203045953.GE26668@spearce.org> <Pine.LNX.4.64.0612030938140.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 3 Dec 2006 17:57:08 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33120>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqvaG-0005R9-Vo for gcvg-git@gmane.org; Sun, 03 Dec
 2006 18:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758284AbWLCR44 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 12:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758292AbWLCR44
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 12:56:56 -0500
Received: from main.gmane.org ([80.91.229.2]:6102 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1758283AbWLCR4z (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 12:56:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gqva4-0005fx-7H for git@vger.kernel.org; Sun, 03 Dec 2006 18:56:48 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 03 Dec 2006 18:56:48 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 03 Dec 2006
 18:56:48 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:

> Also, I have to say, one of the reasons I'm interested in your project is 
> that I've never done any Java programming, because quite frankly, I've 
> never had any reason what-so-ever to do so. But if there is some simple 
> setup, and you have jgit exposed somewhere as a git archive, I'd love to 
> take a look, if only to finally learn more about Java.

GitWiki tells us about egit/jgit repository at
  http://www.spearce.org/projects/scm/egit.git
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

