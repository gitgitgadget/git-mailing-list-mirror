From: Dave Jones <davej@redhat.com>
Subject: diff against a tag ?
Date: Thu, 28 Apr 2005 16:09:53 -0400
Message-ID: <20050428200953.GD8514@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Apr 28 22:06:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRFFt-0002Ri-Qc
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 22:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbVD1UKP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 16:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbVD1UKP
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 16:10:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5062 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262261AbVD1UJ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 16:09:58 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j3SK9rpN027071
	for <git@vger.kernel.org>; Thu, 28 Apr 2005 16:09:53 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j3SK9rO27424
	for <git@vger.kernel.org>; Thu, 28 Apr 2005 16:09:53 -0400
Received: from devserv.devel.redhat.com (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j3SK9rXu008421
	for <git@vger.kernel.org>; Thu, 28 Apr 2005 16:09:53 -0400
Received: (from davej@localhost)
	by devserv.devel.redhat.com (8.12.11/8.12.11/Submit) id j3SK9rwf008418
	for git@vger.kernel.org; Thu, 28 Apr 2005 16:09:53 -0400
X-Authentication-Warning: devserv.devel.redhat.com: davej set sender to davej@redhat.com using -f
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Maybe I missed this in the discussion on tags recently
(I kinda tuned out after a while on that thread).

Is there an easy way to express 'show me the diff
between HEAD and 2.6.12rc3' today ?
Looking at the commit for rc3, theres nothing obvious
to me distinguishing it from any other commit
other than the "Linux v2.6.12-rc3" in the description,
which makes it somewhat difficult to automate.

		Dave

