From: supadhyay <supadhyay@imany.com>
Subject: how to clone/checkout branch/tag vesion from GIT repository
Date: Thu, 10 May 2012 06:39:47 -0700 (PDT)
Message-ID: <1336657187852-7546744.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 15:39:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSTaz-0001Fp-VH
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 15:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758377Ab2EJNjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 09:39:49 -0400
Received: from sam.nabble.com ([216.139.236.26]:51134 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753197Ab2EJNjs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 09:39:48 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <supadhyay@imany.com>)
	id 1SSTat-0000dA-SJ
	for git@vger.kernel.org; Thu, 10 May 2012 06:39:47 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197562>

Hi All,

I try to use below command to do clone from particular branch/version
number. I used below command...

$ git clone -b br6-1-0 ssh://gitolite@myservername/testrep
Cloning into 'testrep'...
remote: Counting objects: 19536, done.
remote: Compressing objects: 100% (5850/5850), done.
remote: Total 19536 (delta 13869), reused 18869 (delta 13202)
Receiving objects: 100% (19536/19536), 61.44 MiB | 17 KiB/s, done.
Resolving deltas: 100% (13869/13869), done.
warning: Remote branch br6-0 not found in upstream origin, using HEAD
instead


End user query is - they want the clone from particular branch which is
separate from Head so I run above commmand. Can any one please help me how
to resolve this?


Is there any way to findout how many branches are available in my GIT
repository. 



Thanks in advance...

--
View this message in context: http://git.661346.n2.nabble.com/how-to-clone-checkout-branch-tag-vesion-from-GIT-repository-tp7546744.html
Sent from the git mailing list archive at Nabble.com.
