From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Wed, 10 Jan 2007 01:26:19 +0100
Organization: At home
Message-ID: <eo1bqu$hji$1@sea.gmane.org>
References: <87ps9xgkjo.wl%cworth@cworth.org> <7virfprquo.fsf@assigned-by-dhcp.cox.net> <87odphgfzz.wl%cworth@cworth.org> <7vbql9ydd7.fsf@assigned-by-dhcp.cox.net> <20070108131735.GA2647@coredump.intra.peff.net> <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net> <20070109142130.GA10633@coredump.intra.peff.net> <7virffkick.fsf@assigned-by-dhcp.cox.net> <20070109213117.GB25012@fieldses.org> <87zm8ryiyz.wl%cworth@cworth.org> <20070109234421.GD30023@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jan 10 01:26:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4RIX-0008RG-Vm
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 01:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbXAJA0b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 19:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbXAJA0b
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 19:26:31 -0500
Received: from main.gmane.org ([80.91.229.2]:60673 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932591AbXAJA0a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 19:26:30 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H4RII-00021R-PK
	for git@vger.kernel.org; Wed, 10 Jan 2007 01:26:18 +0100
Received: from host-81-190-20-31.torun.mm.pl ([81.190.20.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Jan 2007 01:26:18 +0100
Received: from jnareb by host-81-190-20-31.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Jan 2007 01:26:18 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-31.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36441>

Shawn O. Pearce wrote:

> In my mind that is a small price to pay for making sure the
> commit currently in a detached HEAD doesn't get orphaned off
> into never-never land.

By the way, would detached HEAD be reflogged, and if it would
(and certainly it would be nice to have, because protection or
not sh*t happens) how it would be implemented?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
