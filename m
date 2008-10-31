From: 7rans <transfire@gmail.com>
Subject: commit type
Date: Fri, 31 Oct 2008 17:58:25 +0000 (UTC)
Message-ID: <loom.20081031T174821-603@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 19:01:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvyJF-0003sA-BH
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 19:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbYJaSAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 14:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbYJaSAH
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 14:00:07 -0400
Received: from main.gmane.org ([80.91.229.2]:53176 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673AbYJaSAF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 14:00:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KvyHy-0002Qm-Fz
	for git@vger.kernel.org; Fri, 31 Oct 2008 18:00:03 +0000
Received: from 216.241.118.70.cfl.res.rr.com ([70.118.241.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 18:00:02 +0000
Received: from transfire by 216.241.118.70.cfl.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 18:00:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 70.118.241.216 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.3) Gecko/2008092510 Ubuntu/8.04 (hardy) Firefox/3.0.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99614>

Hi--

I have a feature request.

I'd like to be a able to add a commit type to my commits, like 'major', 'minor',
'bug', etc. it would be useful in reviewing changes, especially when listing
changes for end-users to see, because then miscellaneous/administrative commits
could be omitted and only changes important to users listed.

Currently I achieve this by adding "[type]" to the end of my commit messages.
But of course that's less than optimal. I think being able to add a commit type
would be generally useful to everyone, and really has no downside becuase you do
not need to use it if you prefer not.

Thanks,
trans.
