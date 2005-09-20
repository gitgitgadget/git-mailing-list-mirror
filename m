From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: "git pull" on cogito broken?
Date: 20 Sep 2005 11:23:05 -0700
Message-ID: <863bnzd2eu.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 20 20:25:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHmm5-0003Nv-CP
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 20:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVITSXS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 14:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbVITSXR
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 14:23:17 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:59766 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S964974AbVITSXQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 14:23:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id B3FD58F6C5
	for <git@vger.kernel.org>; Tue, 20 Sep 2005 11:23:05 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 14684-01-50 for <git@vger.kernel.org>;
 Tue, 20 Sep 2005 11:23:05 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 59C478F6DD; Tue, 20 Sep 2005 11:23:05 -0700 (PDT)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.12.11.11; tzolkin = 7 Chuen; haab = 9 Chen
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9013>


I got this this morning:

    Fetching refs/heads/master from http://www.kernel.org/pub/scm/cogito/cogito.git using http
    Getting pack list
    Getting alternates list
    error: Unable to find 69ba00668be16e44cae699098694286f703ec61d under http://www.kernel.org/pub/scm/cogito/cogito.git/

    Cannot obtain needed object 69ba00668be16e44cae699098694286f703ec61d
    while processing commit 0000000000000000000000000000000000000000.

Something broken there?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
