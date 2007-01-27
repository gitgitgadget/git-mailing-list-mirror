From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 19:52:44 +0100
Organization: At home
Message-ID: <epg6vk$van$1@sea.gmane.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 27 19:51:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAseR-0002zc-Me
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 19:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbXA0Svo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 13:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbXA0Svo
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 13:51:44 -0500
Received: from main.gmane.org ([80.91.229.2]:44756 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335AbXA0Svn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 13:51:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HAseL-0000Z4-2M
	for git@vger.kernel.org; Sat, 27 Jan 2007 19:51:41 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Jan 2007 19:51:41 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Jan 2007 19:51:41 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37981>

Linus Torvalds wrote:

> - teach people about alternatives.

Actually, "git log -p -S'<string>'" is usually much better alternative
to blame / annotate to find who introduced given change and what for;
moreover you can find the <string> which vanished (find also deleted
contents).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
