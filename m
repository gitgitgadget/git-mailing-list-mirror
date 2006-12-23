From: Jakub Narebski <jnareb@gmail.com>
Subject: branch.<name>.merge specifying remote branch name
Date: Sat, 23 Dec 2006 10:14:49 +0100
Organization: At home
Message-ID: <emirt5$kh3$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Dec 23 10:15:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy2yL-0003dv-Ed
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 10:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbWLWJPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 04:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752793AbWLWJPJ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 04:15:09 -0500
Received: from main.gmane.org ([80.91.229.2]:38511 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbWLWJPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 04:15:07 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Gy2y6-0002mu-Bk
	for git@vger.kernel.org; Sat, 23 Dec 2006 10:15:02 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Dec 2006 10:15:02 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Dec 2006 10:15:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35306>

About the discussion about branch.<name>.merge specifying remote branch name
and relative merits of specifying remote branch name (without need for
tracking branch), and local branch name (which is supposedly more user
friendly, and branch name specifies also remote usually)...

Perhaps it is time to resurrect branch.<name>.mergeLocal (or localMerge)
idea, and both sides would be happy (well, at least when one would code
it ;-).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
