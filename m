From: Bill Lear <rael@zopyra.com>
Subject: Pulling peer's branch and getting tracking branch created
Date: Mon, 26 Feb 2007 18:37:51 -0600
Message-ID: <17891.32095.655545.637691@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 01:38:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLqLt-0002MT-EP
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 01:37:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbXB0Ahx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 19:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbXB0Ahw
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 19:37:52 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61749 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbXB0Ahw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 19:37:52 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1R0bpM05521;
	Mon, 26 Feb 2007 18:37:51 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40679>

I can't seem to figure out the correct magic to get my buddy's branch,
and create the appropriate tracking branch at the same time without
doing a clone.

I don't want to branch from my master, just get his branch and the
matching tracking branch...

It's been a long day, so sorry for the simplistic question, but how
do I do this exactly?


Bill
