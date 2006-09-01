From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Fix git_blame
Date: Fri, 01 Sep 2006 11:07:23 +0200
Organization: At home
Message-ID: <ed8t86$cd8$1@sea.gmane.org>
References: <ed8a90$pfn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Sep 01 11:08:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJ50Y-0003QU-Ns
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 11:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWIAJIL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 05:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWIAJIL
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 05:08:11 -0400
Received: from main.gmane.org ([80.91.229.2]:1668 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751330AbWIAJIK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Sep 2006 05:08:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GJ50E-0003Lp-LO
	for git@vger.kernel.org; Fri, 01 Sep 2006 11:07:54 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Sep 2006 11:07:54 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Sep 2006 11:07:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26298>

Aneesh Kumar wrote:

> Converting the default values to array broke the git blame enable
> disable support. Fix the same.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

Hmmm.... git^W got applied (1d3fc68a), but commit message was lost.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
