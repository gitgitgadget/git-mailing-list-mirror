From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git and tagging hook
Date: Tue, 07 Oct 2008 19:28:13 +0200
Organization: At home
Message-ID: <gcg67d$4o2$1@ger.gmane.org>
References: <1223268332.4072.7.camel@localhost> <48E9BB72.2080008@op5.se> <1223399613.20250.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: scmbug-users@lists.mkgnu.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 07 19:29:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnGNS-0007Dw-6h
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 19:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbYJGR2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 13:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbYJGR2b
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 13:28:31 -0400
Received: from main.gmane.org ([80.91.229.2]:36272 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbYJGR2a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 13:28:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KnGMC-0008EJ-M9
	for git@vger.kernel.org; Tue, 07 Oct 2008 17:28:24 +0000
Received: from abww108.neoplus.adsl.tpnet.pl ([83.8.246.108])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 17:28:24 +0000
Received: from jnareb by abww108.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 17:28:24 +0000
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abww108.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97732>

Kristis Makris wrote:

> But the post-receive is NOT executed when I apply a tag.
> 
> I want the integration when I apply the tag to a local repository, NOT
> only when I push/pull.

If you are talking about taging locally, you can simply make an alias
or do something after tagging. Search archives for description when
it is worth to add a hook, and when it is not.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
