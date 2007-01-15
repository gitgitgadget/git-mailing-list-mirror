From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: git-svn - username/password
Date: 15 Jan 2007 15:25:28 -0800
Message-ID: <8664b73maf.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 16 00:26:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6bDJ-0000Y7-HB
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 00:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbXAOXZc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 18:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbXAOXZb
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 18:25:31 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:29788 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105AbXAOXZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 18:25:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 14FF28D646
	for <git@vger.kernel.org>; Mon, 15 Jan 2007 15:25:29 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 28267-01-4 for <git@vger.kernel.org>;
 Mon, 15 Jan 2007 15:25:28 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 9C7CD8D6C6; Mon, 15 Jan 2007 15:25:28 -0800 (PST)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.13.17.13; tzolkin = 8 Ben; haab = 6 Muan
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36901>


It's not clear from the docs where I'm supposed to put a subversion
username/password in git-svn.  In fact, git-svn makes absolutely no mention of
password.  And I see there's some --username=%s kind of stuff in the arg
parsing, but I'm not able to seem to make it work.  (At one point, git-svn
init actually created a subdir named "http:"... oops!)

Eric?  Or anyone?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
