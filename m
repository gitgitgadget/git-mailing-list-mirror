From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Make search type a popup menu
Date: Wed, 11 Oct 2006 23:15:12 +0200
Organization: At home
Message-ID: <egjmt3$bpn$1@sea.gmane.org>
References: <20061011205817.1855.31725.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Oct 11 23:26:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXlY7-00027d-TC
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 23:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161492AbWJKVVZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 17:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161498AbWJKVVY
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 17:21:24 -0400
Received: from main.gmane.org ([80.91.229.2]:50607 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161490AbWJKVU5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 17:20:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GXlRl-0000D4-CY
	for git@vger.kernel.org; Wed, 11 Oct 2006 23:17:01 +0200
Received: from host-81-190-20-194.torun.mm.pl ([81.190.20.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 23:17:01 +0200
Received: from jnareb by host-81-190-20-194.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 23:17:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-194.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28750>

Petr Baudis wrote:

> This makes the multiple search types actually usable by the user;
> if you don't read the gitweb source, you don't even have an idea
> that you can write things like that there.

It is on one hand a good idea, for users who doesn't read gitweb
sources. It is like "advanced search" in web search engines.

On the other hand it confirms the notion that search types are exclusive.
Currently pickaxe search is exclusive with log message search, but it is
not necessary. Search operators (now limited) and combining them gives
great search power... or rather would give.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
