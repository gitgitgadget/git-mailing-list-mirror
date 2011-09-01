From: Paul Young <paulyoungonline@gmail.com>
Subject: Re: [PATCH v2] git svn : hook before 'git svn dcommit'
Date: Thu, 1 Sep 2011 16:58:07 +0000 (UTC)
Message-ID: <loom.20110901T185405-97@post.gmane.org>
References: <1313438699-9926-1-git-send-email-frederic.heitzmann@gmail.com> <7vty9ijs1i.fsf@alter.siamese.dyndns.org> <20110817003023.GA30153@dcvr.yhbt.net> <CALeToSWJNK=q4iPwxNvgGin0T61oLKJd=b9F3cSSo0vVebrhhQ@mail.gmail.com> <CALeToSUidWgiJ+PxuphnBZOQGNStNOO9==EswfLDpFr2GYy=nA@mail.gmail.com> <20110818091228.GB16549@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 01 19:00:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzAck-00082F-2q
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 19:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677Ab1IARAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 13:00:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:44308 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447Ab1IARAH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 13:00:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QzAcX-0007xQ-HW
	for git@vger.kernel.org; Thu, 01 Sep 2011 19:00:05 +0200
Received: from 5ad3b8fe.bb.sky.com ([90.211.184.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 19:00:05 +0200
Received: from paulyoungonline by 5ad3b8fe.bb.sky.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 19:00:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 90.211.184.254 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.218 Safari/535.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180550>

Hi there

I'm trying to set up a post git svn dcommit hook in order to automatically
deliver stories via Pivotal Tracker:

https://www.pivotaltracker.com/help/api?version=v3#subversion_post_commit_example

Do you think you could help?

Thanks.
