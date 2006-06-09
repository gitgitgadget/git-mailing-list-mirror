From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git-daemon messing up permissions for gitweb
Date: Fri, 09 Jun 2006 23:02:03 +0200
Organization: At home
Message-ID: <e6cnk2$s49$1@sea.gmane.org>
References: <5A14AF34CFF8AD44A44891F7C9FF41050795787F@usahm236.amer.corp.eds.com> <Pine.LNX.4.64.0606091321100.5498@g5.osdl.org> <7vodx2m5jp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606091344010.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jun 09 23:02:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Foo7f-0000sc-9m
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 23:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWFIVCY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 17:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWFIVCY
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 17:02:24 -0400
Received: from main.gmane.org ([80.91.229.2]:62666 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030216AbWFIVCX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 17:02:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Foo7O-0000pv-Cq
	for git@vger.kernel.org; Fri, 09 Jun 2006 23:02:10 +0200
Received: from 212-87-13-71.sds.uw.edu.pl ([212.87.13.71])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 23:02:10 +0200
Received: from jnareb by 212-87-13-71.sds.uw.edu.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 23:02:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212-87-13-71.sds.uw.edu.pl
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21558>

I've put proposed solution in GitWiki:

  http://git.or.cz/gitwiki/GitFaq#git-push-ssh-umask

-- 
Jakub Narebski
Warsaw, Poland
