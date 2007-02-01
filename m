From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-checkout: disable guides how to switch branches with ui.guide
Date: Fri, 02 Feb 2007 00:18:43 +0100
Organization: At home
Message-ID: <eptse3$cak$1@sea.gmane.org>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home> <20070131231942.GB31145@coredump.intra.peff.net> <Pine.LNX.4.64.0701311907500.3021@xanadu.home> <20070201030030.GA1979@coredump.intra.peff.net> <7vd54ur26u.fsf@assigned-by-dhcp.cox.net> <7vlkjip7mu.fsf_-_@assigned-by-dhcp.cox.net> <20070201184403.GA6326@moooo.ath.cx> <7vabzxpq2t.fsf@assigned-by-dhcp.cox.net> <20070201205145.GA13439@moooo.ath.cx> <7vabzxoaed.fsf@assigned-by-dhcp.cox.net> <87ps8ta7fx.wl%cworth@cworth.org> <Pine.LNX.4.64.0702011656250.3021@xanadu.home> <87ododa5gl.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 02 00:19:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HClCg-00039v-0P
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 00:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422862AbXBAXSu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 18:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422837AbXBAXSu
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 18:18:50 -0500
Received: from main.gmane.org ([80.91.229.2]:53732 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422838AbXBAXSt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 18:18:49 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HClBP-0007Ke-Uk
	for git@vger.kernel.org; Fri, 02 Feb 2007 00:17:36 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 00:17:35 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 00:17:35 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38425>

Carl Worth wrote:

> On Thu, 01 Feb 2007 16:59:46 -0500 (EST), Nicolas Pitre wrote:

>> Please just display the last commit since this list could get long.
> 
> In that case what might be nice would be if it printed a revision
> specification that could be handed to git-log or gitk for the user to
> inspect the situation.
> 
> And extra nice if it looked like b1189118..ba531642 when possible.

Nice idea. Now only to come up with detailed wording...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
