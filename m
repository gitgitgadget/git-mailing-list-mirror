From: Taylor Hedberg <tmhedberg@gmail.com>
Subject: Re: Git: Unexpected behaviour?
Date: Fri, 11 Nov 2011 16:14:02 -0500
Message-ID: <20111111211401.GF4495@foodlogiq3-xp-d620>
References: <1321044904175-6986736.post@n2.nabble.com>
 <1321045782702-6986770.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jvsrvcs <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 11 22:23:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROyZo-0004gl-P2
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 22:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757299Ab1KKVUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 16:20:11 -0500
Received: from tmh.cc ([173.230.128.92]:33451 "EHLO elara.tmh.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407Ab1KKVUK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 16:20:10 -0500
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Nov 2011 16:20:10 EST
Received: by elara.tmh.cc (Postfix, from userid 1001)
	id 3B1683420A; Fri, 11 Nov 2011 21:14:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on elara.tmh.cc
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,FREEMAIL_FROM
	autolearn=unavailable version=3.3.2
Received: from foodlogiq3-xp-d620 (rrcs-70-61-89-105.midsouth.biz.rr.com [70.61.89.105])
	by elara.tmh.cc (Postfix) with ESMTPSA id A0A00341B5;
	Fri, 11 Nov 2011 21:14:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1321045782702-6986770.post@n2.nabble.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185288>

If you don't want to make a new commit on the branch you are leaving,
you can use `git stash` to stash away your working directory changes in
a temporary holding place without updating any branch.
