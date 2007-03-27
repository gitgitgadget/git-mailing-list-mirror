From: Bill Lear <rael@zopyra.com>
Subject: Listing of branch creation time?
Date: Tue, 27 Mar 2007 15:52:06 -0600
Message-ID: <17929.37382.984339.742025@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 23:52:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWJaP-00055v-2y
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 23:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932954AbXC0VwK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 17:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932966AbXC0VwK
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 17:52:10 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61478 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932954AbXC0VwI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 17:52:08 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l2RLq7I30245;
	Tue, 27 Mar 2007 15:52:07 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43310>

I'm sure the git developers grow tired of working with addle-brained
users, but I sometimes forget what the contents of a topic branch are,
how old it is, etc.  As to content, I can make better branch names,
but I think it would be useful to be able to query git as to the
creation time of all of my branches, perhaps sorted from newest to
oldest.

Would it be reasonable to add an option to git-branch to do this?


Bill
