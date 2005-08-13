From: Kenneth Johansson <ken@canit.se>
Subject: Merge conflict.
Date: Sat, 13 Aug 2005 16:45:32 +0200
Message-ID: <pan.2005.08.13.14.45.32.401071@canit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Aug 13 17:32:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3xyh-0004hK-ML
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 17:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbVHMPbQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 11:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVHMPbQ
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 11:31:16 -0400
Received: from main.gmane.org ([80.91.229.2]:41386 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751337AbVHMPbP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 11:31:15 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1E3xxm-0004cB-He
	for git@vger.kernel.org; Sat, 13 Aug 2005 17:30:22 +0200
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Aug 2005 17:30:22 +0200
Received: from ken by 1-1-4-20a.ras.sth.bostream.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Aug 2005 17:30:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 1-1-4-20a.ras.sth.bostream.se
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I used cogito to do a cg-update and got conflicts and the exact files are
printed to the screen. But say I somehow lost that output is there anyway
to list conflicting files ??

cg-status shows the files as modified but that also includes non
conflicting files.

The best I could find was to do a "git-update-cache --refresh" but that
still do not tell me if I already have removed the conflict in the file.

Is this not something that needs to be answered if we ever are going to
have a graphical merge tool?
