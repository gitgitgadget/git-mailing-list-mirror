From: Jakub Narebski <jnareb@gmail.com>
Subject: qgit idea: interface for cherry-picking
Date: Sun, 02 Jul 2006 21:01:10 +0200
Organization: At home
Message-ID: <e8954u$srh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Jul 02 21:01:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx7C2-0006Uq-FY
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 21:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932792AbWGBTBM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 15:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932800AbWGBTBM
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 15:01:12 -0400
Received: from main.gmane.org ([80.91.229.2]:47059 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932792AbWGBTBL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 15:01:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fx7Bp-0006Sp-BY
	for git@vger.kernel.org; Sun, 02 Jul 2006 21:01:05 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Jul 2006 21:01:05 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Jul 2006 21:01:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23113>

Currently in qgit one can git-format-patch a commit. It woul be nice if one
would be able to git-cherry-pick and git-cherry-pick -n a commit (denoting
the head, i.e. where cherry pick would be applied to). It would be very
usefull in reordering patches (cleaning up history).  

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
