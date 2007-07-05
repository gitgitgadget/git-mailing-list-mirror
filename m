From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: [BUG] Documentation/git-stash.txt slight typo
Date: Wed, 04 Jul 2007 21:09:16 -0700
Message-ID: <86abubo5jn.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 05 06:09:29 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6Ien-0006QR-7W
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 06:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbXGEEJR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 00:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbXGEEJR
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 00:09:17 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:21824 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbXGEEJR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 00:09:17 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id C011E1DEEBB; Wed,  4 Jul 2007 21:09:16 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.8.3; tzolkin = 9 Akbal; haab = 11 Tzec
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51653>


But I don't know how to fix, since I don't know asciidoc.

For the diagram:

            .----W
           /    /
     ...--H----I

the last line disappears in the manpage.  Must be something to do with
the leading dots.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
