From: David Soria <sn_@gmx.net>
Subject: [PATCH] GPG Signing of Commits
Date: Thu, 2 Aug 2007 22:15:00 +0000 (UTC)
Message-ID: <f8tl14$o4r$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 03 00:20:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGj1g-0005pB-Iu
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 00:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756214AbXHBWUI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 18:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756080AbXHBWUI
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 18:20:08 -0400
Received: from main.gmane.org ([80.91.229.2]:45281 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755911AbXHBWUG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 18:20:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IGj1W-0001Ma-II
	for git@vger.kernel.org; Fri, 03 Aug 2007 00:20:02 +0200
Received: from 26-81-235-201.fibertel.com.ar ([201.235.81.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 00:20:02 +0200
Received: from sn_ by 26-81-235-201.fibertel.com.ar with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 00:20:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 26-81-235-201.fibertel.com.ar
User-Agent: pan 0.120 (Plate of Shrimp)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54630>

Hi list,

i personally like the feature of signing commit messages using GPG. What
do you think about the patch? It's just the mechanism taken from git-tag.
Would be good not just have validation for tags, but for commits. 

you found the patch at
http://experimentalworks.net/~dsp/0002-Allow-the-usage-of-GPG-signing-in-commits.patch

Hopefully you like it,
 David
