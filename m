From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: finding the right remote branch for a commit
Date: Thu, 12 Jul 2007 11:33:32 +0200
Organization: At home
Message-ID: <f74s56$cuc$1@sea.gmane.org>
References: <20070710144907.GA324@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0707112226170.4516@racer.site> <20070712074745.GA28507@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 11:27:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8uxI-0005gz-Hw
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 11:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755647AbXGLJ1V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 05:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754667AbXGLJ1V
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 05:27:21 -0400
Received: from main.gmane.org ([80.91.229.2]:41476 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753870AbXGLJ1U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 05:27:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I8ux7-0001S5-W2
	for git@vger.kernel.org; Thu, 12 Jul 2007 11:27:13 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 11:27:13 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 11:27:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52261>

martin f krafft wrote:

> Yes, it does. I am downloading the source now and intend to work
> with the HEAD (is that the right term for what I used to call trunk
> when I was doing SVN?) from now on (instead of the Debian package).

HEAD means _current_ branch. You can work off 'master' or 'next' branches,
and if you feel really adventurous even off 'pu' branch.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
