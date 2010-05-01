From: Steve Folly <steve@spfweb.co.uk>
Subject: Revert hunk?
Date: Sat, 1 May 2010 19:54:38 +0000 (UTC)
Message-ID: <loom.20100501T215211-11@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 01 21:54:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Im6-00059E-2Q
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 21:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757555Ab0EATyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 15:54:49 -0400
Received: from lo.gmane.org ([80.91.229.12]:59698 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754077Ab0EATys (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 15:54:48 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O8Ily-00053Q-Cd
	for git@vger.kernel.org; Sat, 01 May 2010 21:54:46 +0200
Received: from cpc1-haye16-0-0-cust629.haye.cable.virginmedia.com ([92.234.82.118])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 May 2010 21:54:46 +0200
Received: from steve by cpc1-haye16-0-0-cust629.haye.cable.virginmedia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 May 2010 21:54:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 92.234.82.118 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; en-gb) AppleWebKit/531.21.11 (KHTML, like Gecko) Version/4.0.4 Safari/531.21.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146117>

git gui has an option to revert changes, but that applies
to the whole file. Is there an option to revert a line 
or hunk rather than the whole file?

Thanks,
Steve
