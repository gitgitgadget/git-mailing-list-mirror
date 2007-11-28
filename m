From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git guidance
Date: Wed, 28 Nov 2007 19:41:01 +0100
Organization: At home
Message-ID: <fikcns$mte$1@ger.gmane.org>
References: <20071127235237.GF15227@1wt.eu> <200711282014.27299.a1426z@gawab.com> <Pine.LNX.4.64.0711281811500.27959@racer.site> <200711282130.12864.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 19:42:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxRrK-0006oI-Oa
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 19:42:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbXK1Slr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 13:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752891AbXK1Slr
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 13:41:47 -0500
Received: from main.gmane.org ([80.91.229.2]:43173 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168AbXK1Slq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 13:41:46 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IxRqV-0004Zm-Or
	for git@vger.kernel.org; Wed, 28 Nov 2007 18:41:15 +0000
Received: from abvr156.neoplus.adsl.tpnet.pl ([83.8.215.156])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 18:41:15 +0000
Received: from jnareb by abvr156.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 18:41:15 +0000
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git,gmane.linux.kernel
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvr156.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66401>

Al Boldi wrote:
> Johannes Schindelin wrote:

>> By that definition, no SCM, not even CVS, is transparent.  Nothing short
>> of unpacked directories of all versions (wasting a lot of disk space)
>> would.
> 
> Who said anything about unpacking?
> 
> I'm talking about GIT transparently serving a Virtual Version Control dir to 
> be mounted on the client.

Are you talking about something like (in alpha IIRC) gitfs?

  http://www.sfgoth.com/~mitch/linux/gitfs/


Besides, you can always use "git show <revision>:<file>". For example
gitweb (and I think other web interfaces) can show any version of a file
or a directory, accessing only repository.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
