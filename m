From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Restore object-named links in item lists
Date: Tue, 24 Oct 2006 10:51:53 +0200
Organization: At home
Message-ID: <ehkk6e$mk5$1@sea.gmane.org>
References: <20061024031240.2500.93420.stgit@rover> <20061024033610.7959.4028.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Oct 24 10:52:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcI0n-0003hx-Pc
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 10:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWJXIvv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 04:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWJXIvv
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 04:51:51 -0400
Received: from main.gmane.org ([80.91.229.2]:29093 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030232AbWJXIvu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 04:51:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GcI0Z-0003f3-IT
	for git@vger.kernel.org; Tue, 24 Oct 2006 10:51:39 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 10:51:39 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 10:51:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29948>

Petr Baudis wrote:

> This restores the redundant links removed earlier. It supersedes my patch
> to stick slashes to tree entries.

I would put those "redundant links" in separate column (like for git_tags).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
