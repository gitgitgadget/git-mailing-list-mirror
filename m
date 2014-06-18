From: James Coleman <jtc331@gmail.com>
Subject: Re: Possible bug in =?utf-8?b?YGdpdA==?= =?utf-8?b?cmVzZXRg?= in 1.9
Date: Wed, 18 Jun 2014 17:20:37 +0000 (UTC)
Message-ID: <loom.20140618T191909-464@post.gmane.org>
References: <CAAaqYe9FcjE9v+bkcnkPim8ntFvbUy72dJJCGs7974dq_9eSOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:25:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJbm-00083a-2Q
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874AbaFRRZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:25:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:50375 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755AbaFRRZG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:25:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WxJbc-0007su-Pv
	for git@vger.kernel.org; Wed, 18 Jun 2014 19:25:05 +0200
Received: from 64-128-71-2.static.twtelecom.net ([64-128-71-2.static.twtelecom.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 19:25:04 +0200
Received: from jtc331 by 64-128-71-2.static.twtelecom.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 19:25:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 64.128.71.2 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.76.4 (KHTML, like Gecko) Version/7.0.4 Safari/537.76.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252013>

Followup on this, it looks like the local repository actually didn't contain
branch-2. So this doesn't appear to be an issue.
