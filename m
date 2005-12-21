From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Am I doing something wrong?
Date: 21 Dec 2005 08:51:13 -0800
Message-ID: <86k6dyxuke.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Dec 21 17:53:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ep7BR-0007ns-Ia
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 17:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVLUQvT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 11:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVLUQvT
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 11:51:19 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:45928 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751138AbVLUQvS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 11:51:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id C06DF8F8DB
	for <git@vger.kernel.org>; Wed, 21 Dec 2005 08:51:13 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 06812-01-54 for <git@vger.kernel.org>;
 Wed, 21 Dec 2005 08:51:13 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 25B938F8F9; Wed, 21 Dec 2005 08:51:13 -0800 (PST)
To: git <git@vger.kernel.org>
x-mayan-date: Long count = 12.19.12.16.3; tzolkin = 8 Akbal; haab = 1 Kankin
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13879>


localhost:~/MIRROR/git-GIT % cg-fetch
Recovering from a previously interrupted fetch...
Fetching head...
Fetching objects...
Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
Getting pack list for http://www.kernel.org/pub/scm/git/git.git/
error: Unable to find c2f3bf071ee90b01f2d629921bb04c4f798f02fa under http://www.kernel.org/pub/scm/git/git.git/

Cannot obtain needed object c2f3bf071ee90b01f2d629921bb04c4f798f02fa
while processing commit 0000000000000000000000000000000000000000.
cg-fetch: objects fetch failed

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
