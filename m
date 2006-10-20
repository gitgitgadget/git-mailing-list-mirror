From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Sat, 21 Oct 2006 01:24:51 +0200
Organization: At home
Message-ID: <ehblrq$lh3$1@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca> <200610201821.34712.jnareb@gmail.com> <20061020181210.GA29843@artax.karlin.mff.cuni.cz> <Pine.LNX.4.64.0610201133260.3962@g5.osdl.org> <1161382416.9241.19.camel@localhost.localdomain> <1161385512.13697.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Sat Oct 21 01:25:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb3jV-0000As-U9
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 01:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbWJTXYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 19:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbWJTXYz
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 19:24:55 -0400
Received: from main.gmane.org ([80.91.229.2]:36284 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161051AbWJTXYy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 19:24:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gb3jQ-00009w-Lh
	for git@vger.kernel.org; Sat, 21 Oct 2006 01:24:52 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 01:24:52 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 01:24:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29555>

Robert Collins wrote:

> However, I'm still convinced that tracking the user intention of renames
> leads to a slicker system than renames via inference.

Well, there was (abandoned for now) idea of rr2-cache, the cache of how
renames were resolved during merge conflict resolving.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
