From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Alternate revno proposal (Was: Re: VCS comparison table)
Date: Thu, 19 Oct 2006 00:14:02 +0200
Organization: At home
Message-ID: <eh68va$7er$1@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610170119.09066.jnareb@gmail.com> <45346290.6050300@utoronto.ca> <200610171120.09747.jnareb@gmail.com> <1161078035.9020.73.camel@localhost.localdomain> <Pine.LNX.4.64.0610170921540.3962@g5.osdl.org> <1161124078.9020.88.camel@localhost.localdomain> <20061017191838.1c36499b.seanlkml@sympatico.ca> <20061017233305.GG20017@pasky.or.cz> <1161149200.3423.34.camel@localhost.localdomain> <20061018214623.GA32725@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Thu Oct 19 00:14:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJg6-0008Os-Aw
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 00:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423076AbWJRWOT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 18:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423078AbWJRWOT
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 18:14:19 -0400
Received: from main.gmane.org ([80.91.229.2]:32953 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1423076AbWJRWOS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 18:14:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GaJfw-0008NE-4b
	for git@vger.kernel.org; Thu, 19 Oct 2006 00:14:12 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 00:14:12 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 00:14:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29292>

Jan Hudec wrote:

> Comments?

What about fetching from repository? For revnos you have to assign revno for
all commit you have downloaded; now you need only to unpack received pack
(or not, if you used --keep option). More work.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
