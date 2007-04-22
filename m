From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: fetch failure from git2.kernel.org?
Date: Sun, 22 Apr 2007 03:03:45 -0700
Message-ID: <86fy6ssp32.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 22 12:03:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfYvH-0001vX-7w
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 12:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbXDVKDq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 06:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754167AbXDVKDq
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 06:03:46 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:1641 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbXDVKDp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 06:03:45 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id A5D001DE587; Sun, 22 Apr 2007 03:03:45 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.4.10; tzolkin = 1 Oc; haab = 18 Pop
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45233>


is this known?  transient?

    $ git-fetch
    warning: no common commits
    remote: Generating pack...
    remote: Done counting 0 objects.
    remote: aborting due to possible repository corruption on the remote side.
    fatal: protocol error: bad pack header
    fatal: Fetch failure: git://git2.kernel.org/pub/scm/git/git.git
    $

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
