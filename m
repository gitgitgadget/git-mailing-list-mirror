From: Lenka Dubcova <dubcova@gmail.com>
Subject: git rebase --interactive problem
Date: Fri, 21 Aug 2009 16:12:25 -0500 (CDT)
Message-ID: <1250889145942-3492625.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 23:12:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MebPW-0005Pd-Fr
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 23:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbZHUVMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 17:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbZHUVMZ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 17:12:25 -0400
Received: from 216-139-236-80.aus.us.siteprotect.com ([216.139.236.80]:4036
	"EHLO jim.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932318AbZHUVMY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 17:12:24 -0400
Received: from jim ([127.0.0.1]) by jim.nabble.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 21 Aug 2009 16:12:25 -0500
X-Nabble-From: dubcova@gmail.com
X-OriginalArrivalTime: 21 Aug 2009 21:12:25.0957 (UTC) FILETIME=[1539C950:01CA22A4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126756>


Hi,

I wanted to squash one commit to another using git rebase --interactive
HEAD~2, but I made a typo, instead of squash I wrote sqaush, so it stopped
and left this message

Unknown command: sqaush 43ce3ae my commit message
Please fix this in the file
/home/lenka/hermes2d/.git/.dotest-merge/git-rebase-todo.

Moreover it jumped from my branch to (no branch).

So I corrected it in "git-rebase-todo" and saved, but I don't know what to
do next.

Thanks,
Lenka
-- 
View this message in context: http://n2.nabble.com/git-rebase-interactive-problem-tp3492625p3492625.html
Sent from the git mailing list archive at Nabble.com.
