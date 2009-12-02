From: Wenguang Wang <wenguang@apple.com>
Subject: How to include full commit logs in git merge message?
Date: Wed, 2 Dec 2009 07:30:17 +0000 (UTC)
Message-ID: <loom.20091202T082853-425@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 08:35:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFjjz-00013l-KR
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 08:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbZLBHe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 02:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbZLBHe7
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 02:34:59 -0500
Received: from lo.gmane.org ([80.91.229.12]:39068 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753359AbZLBHe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 02:34:58 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NFjjs-00010x-3k
	for git@vger.kernel.org; Wed, 02 Dec 2009 08:35:04 +0100
Received: from adsl-67-117-147-85.dsl.snfc21.pacbell.net ([67.117.147.85])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 08:35:04 +0100
Received: from wenguang by adsl-67-117-147-85.dsl.snfc21.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 08:35:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.117.147.85 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_2; en-us) AppleWebKit/531.21.8 (KHTML, like Gecko) Version/4.0.4 Safari/531.21.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134311>

Hi,

When I merge a branch, say myfix, to master,
I would like to let the merge log message contain
all commit messages I had for the branch I am 
merging.  However, the "git merge --log" only
populates one-line descriptions of the commits.

Is there any simple way to populate the full 
merge messages into the log message of the 
merge commit?

Thanks!

-Wenguang
