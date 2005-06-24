From: Markus Dahms <mad@automagically.de>
Subject: [Cogito] less verbose cg-clone/cg-update?
Date: Fri, 24 Jun 2005 08:46:33 +0200
Message-ID: <pan.2005.06.24.06.46.32.339572@automagically.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Jun 24 08:51:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dli1s-0004SP-0W
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 08:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbVFXG5V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 02:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbVFXG5V
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 02:57:21 -0400
Received: from main.gmane.org ([80.91.229.2]:30920 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S263183AbVFXG5C (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 02:57:02 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Dli16-0004Iz-9V
	for git@vger.kernel.org; Fri, 24 Jun 2005 08:50:20 +0200
Received: from pd9528b4d.dip0.t-ipconnect.de ([217.82.139.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Jun 2005 08:50:20 +0200
Received: from mad by pd9528b4d.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Jun 2005 08:50:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9528b4d.dip0.t-ipconnect.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi there,

as a person just following the development process of Linux/GIT/etc.
I'm normally not interested in SHA-1 sums on updating my local tree.
IMHO the default output should be less verbose (like in most VCSs),
especially in file changes the type of change (N/M/...) and the
file name may be enough.
Given an option (e.g. "-v") there could be a lot more...

If there's no time, I'd do the patch...

Markus

P.S.: I didn't really look at the source, maybe it's a git not
      a cg-* change...

-- 
A CRAY is the only computer that runs an endless loop in just 4 hours...

