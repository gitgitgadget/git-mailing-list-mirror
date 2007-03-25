From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Subproject status
Date: Mon, 26 Mar 2007 01:34:08 +0200
Organization: At home
Message-ID: <eu70tc$38c$1@sea.gmane.org>
References: <Pine.LNX.4.64.0703251304280.6485@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 01:34:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVcEL-0000E6-Jb
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 01:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbXCYXea (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 19:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753533AbXCYXea
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 19:34:30 -0400
Received: from main.gmane.org ([80.91.229.2]:59147 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753526AbXCYXe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 19:34:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HVcE4-0006Cq-Hl
	for git@vger.kernel.org; Mon, 26 Mar 2007 01:34:16 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 01:34:16 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 01:34:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43092>

[Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org]

Daniel Barkalow wrote:

> I remember that last time I checked, there were a number of designs for 
> subprojects and at least a couple of implementations, but none that was 
> complete to the point of being mergeable. Are there any subproject 
> implementations available that haven't run into unsolveable problems? I'm 
> presently only looking at stuff that totals to a reasonable single project 
> size and rate of growth, so I'm not worried about the large-scale storage 
> requirement issue.

Check out http://git.or.cz/gitwiki/SubprojectSupport


Could _please_ anyone who wrote some kind of submodule support, add info
about it (links to archive, to repository, perhaps to working prototype)
to this page? Thanks in advance!
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
