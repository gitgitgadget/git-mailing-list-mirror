From: hogsolo <greg@localdirt.com>
Subject: Basic Git usage
Date: Fri, 13 Aug 2010 21:32:38 -0700 (PDT)
Message-ID: <1281760358285-5422412.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 14 06:32:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok8QS-000744-25
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 06:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858Ab0HNEcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 00:32:39 -0400
Received: from kuber.nabble.com ([216.139.236.158]:49220 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab0HNEci (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 00:32:38 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <greg@localdirt.com>)
	id 1Ok8QA-0005p1-9O
	for git@vger.kernel.org; Fri, 13 Aug 2010 21:32:38 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153547>


Hi, Im new to Git, formerly an SVN user.
I have a master repo and have created a branch. I want to work in both at
the same time. I want to change some files in the master, then switch to the
branch ( git checkout branchname) , work on some files, then switch back to
the master. 
However git wont let me switch back to the master until I have added,
committed and pushed my files in the branch. 
Is this correct behavior for git? It would seem that I not be REQUIRED to
check in anything I was working on before switching between branch and
master, but that's the behavior I'm seeing via error messages.

thanks


-- 
View this message in context: http://git.661346.n2.nabble.com/Basic-Git-usage-tp5422412p5422412.html
Sent from the git mailing list archive at Nabble.com.
