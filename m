From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: something broken just now on git-pull from openbsd to OSX
Date: 18 Aug 2006 09:17:48 -0700
Message-ID: <86pseykogj.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 18 18:18:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE72u-00088c-RQ
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 18:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWHRQRu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 12:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWHRQRu
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 12:17:50 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:52143 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751284AbWHRQRt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 12:17:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id E41948FBFA
	for <git@vger.kernel.org>; Fri, 18 Aug 2006 09:17:48 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 10398-01-39 for <git@vger.kernel.org>;
 Fri, 18 Aug 2006 09:17:48 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 7BDAD8FBFB; Fri, 18 Aug 2006 09:17:48 -0700 (PDT)
To: git <git@vger.kernel.org>
x-mayan-date: Long count = 12.19.13.10.3; tzolkin = 1 Akbal; haab = 16 Yaxkin
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25672>


I just updated my openbsd's GIT to 1.4.2.g55c3, and now my
git-fetch from there to my OSX fails with a fatal error almost immediately.

What just changed?  What can I check?

git-fetch from other repositories to OSX seems to work fine.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
