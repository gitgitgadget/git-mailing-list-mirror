From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: svn-cp equivalent for history on a single file from a git-svn user.
Date: Mon, 28 May 2007 02:41:43 +0200
Organization: At home
Message-ID: <f3d86i$p5s$1@sea.gmane.org>
References: <20070527101430.GA27013@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 28 02:37:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsTEP-0004iG-7l
	for gcvg-git@gmane.org; Mon, 28 May 2007 02:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747AbXE1Ag7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 20:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753718AbXE1Ag7
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 20:36:59 -0400
Received: from main.gmane.org ([80.91.229.2]:55407 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752681AbXE1Ag6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 20:36:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HsTE9-000485-6r
	for git@vger.kernel.org; Mon, 28 May 2007 02:36:49 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 May 2007 02:36:49 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 May 2007 02:36:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48603>

Robin H. Johnson wrote:

> The Git docs say to use plain 'cp' where svn-cp would be used, as Git
> detects copies after-the-fact.

But I think you need to _request_ detecting copies with '-C' option.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
