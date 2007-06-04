From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries too.
Date: Tue, 05 Jun 2007 01:46:39 +0200
Organization: At home
Message-ID: <f427ur$ohs$1@sea.gmane.org>
References: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 01:41:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvMBK-0008P9-BG
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 01:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757375AbXFDXll (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 19:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757482AbXFDXll
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 19:41:41 -0400
Received: from main.gmane.org ([80.91.229.2]:39666 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757375AbXFDXlk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 19:41:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HvMB2-0005kG-Dt
	for git@vger.kernel.org; Tue, 05 Jun 2007 01:41:32 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 01:41:32 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 01:41:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49140>

Bryan Childs wrote:

> 3) With a central repository, for which we have a limited number of
> individuals having commit access, it's easy for us to automate a build
> based on each commit the repository receives.

Check out contrib/continuous/ scripts in git repository: you would have
to enable it only on one machine, of course.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
