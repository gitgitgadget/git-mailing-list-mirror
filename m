From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: git-log to go forward instead of reverse?
Date: 10 Jul 2006 11:42:30 -0700
Message-ID: <86bqrxpai1.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 10 20:42:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G00iI-0007eh-Ig
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 20:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422758AbWGJSmc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 14:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422760AbWGJSmc
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 14:42:32 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:31321 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1422758AbWGJSmb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 14:42:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id BCCA08F3E9
	for <git@vger.kernel.org>; Mon, 10 Jul 2006 11:42:30 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 10108-01-19 for <git@vger.kernel.org>;
 Mon, 10 Jul 2006 11:42:30 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 370198F5C8; Mon, 10 Jul 2006 11:42:30 -0700 (PDT)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.13.8.4; tzolkin = 1 Kan; haab = 17 Tzec
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23635>


Am I missing an option to have git-log go forward in time rather than
backward?  I'd really like "git-log --pretty=short ORIG_HEAD..HEAD" to show me
a story I can read. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
