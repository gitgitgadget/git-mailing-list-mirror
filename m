X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Collection of stgit issues and wishes
Date: Sun, 10 Dec 2006 09:55:13 +0100
Organization: At home
Message-ID: <elght6$tjb$1@sea.gmane.org>
References: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net> <elconr$uku$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 10 Dec 2006 08:53:22 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33870>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtKQy-00030N-4q for gcvg-git@gmane.org; Sun, 10 Dec
 2006 09:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760504AbWLJIxP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 03:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760513AbWLJIxP
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 03:53:15 -0500
Received: from main.gmane.org ([80.91.229.2]:38463 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760504AbWLJIxP
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 03:53:15 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GtKQk-00059w-H3 for git@vger.kernel.org; Sun, 10 Dec 2006 09:53:06 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 09:53:06 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 10 Dec 2006
 09:53:06 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:

> Here are some issues which are a bit annoying for me:
> - make "stg help" (without command name) equivalent to "stg --help"
> - stg new lacks --sign option (I have to remember to do this during
>   "stg refresh").

And another one: git uses VISUAL, then EDITOR, while stgit uses EDITOR
only, so when I prepare VISUAL for git (I use emacsclient), stgit still
uses EDITOR.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

