From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Thu, 08 Feb 2007 00:53:59 +0100
Organization: At home
Message-ID: <eqdoql$4up$1@sea.gmane.org>
References: <17866.20355.744025.133326@lisa.zopyra.com> <Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org> <7vd54l60gg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071525270.8424@woody.linux-foundation.org> <7vtzxx4k1c.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071539390.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 00:54:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEwcf-0006II-SD
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 00:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422814AbXBGXyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 18:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422805AbXBGXyT
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 18:54:19 -0500
Received: from main.gmane.org ([80.91.229.2]:37898 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422814AbXBGXyS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 18:54:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HEwc1-0001Gr-60
	for git@vger.kernel.org; Thu, 08 Feb 2007 00:54:05 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 00:54:05 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 00:54:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39006>

Linus Torvalds wrote:
> On Wed, 7 Feb 2007, Junio C Hamano wrote:
>> 
>> Heh, I do not care if you find "log -g" pretty, since I do not
>> particularly find it pretty ("log --pretty=o --abbrev-commit -g"
>> is probably prettier than "less").
> 
> With "--pretty=oneline --abbrev-commit" I'll agree that it's actually 
> fairly pretty.

By the way, --abbrev-commit is currently not documented...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
