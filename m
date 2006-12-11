X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] CGit v0.1-pre
Date: Mon, 11 Dec 2006 01:08:50 +0100
Organization: At home
Message-ID: <eli7e3$srp$1@sea.gmane.org>
References: <8c5c35580612101542n72d300c7o106e53e219670510@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 11 Dec 2006 00:07:00 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 18
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33966>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtYh6-0003UN-S6 for gcvg-git@gmane.org; Mon, 11 Dec
 2006 01:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760455AbWLKAGx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 19:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760473AbWLKAGx
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 19:06:53 -0500
Received: from main.gmane.org ([80.91.229.2]:44986 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1757046AbWLKAGw
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 19:06:52 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GtYgw-0007Rv-Lf for git@vger.kernel.org; Mon, 11 Dec 2006 01:06:46 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 01:06:46 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 11 Dec 2006
 01:06:46 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Lars Hjemli wrote:

> CGit is another cgi-app for git.

I have added this to GitWiki: check out
  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#cgit

Hmmm... git has now 4 web interfaces (5 if counting gittracker, which works
but gittracker repository shows empty): gitweb in Perl, git-php in PHP, wit
in Python (is it actively developed? where it can be downloaded from?),
gitarella in Ruby, now CGit in C...

By the way, it is cgit, CGit or CGIt ;-p?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

