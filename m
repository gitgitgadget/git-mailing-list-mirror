From: Bill Lear <rael@zopyra.com>
Subject: 'git checkout -f' versus 'git reset --hard'
Date: Thu, 5 Apr 2007 08:36:09 -0500
Message-ID: <17940.64329.10165.993967@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 15:36:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZS8S-0003bg-5u
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 15:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992722AbXDENgM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 09:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992726AbXDENgL
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 09:36:11 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60944 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992722AbXDENgK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 09:36:10 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l35Da9f07378;
	Thu, 5 Apr 2007 07:36:09 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43825>

After a failed merge, I want to undo things.  I typically use git
reset --hard, and it works like a charm.  Others have tried to use git
checkout -f, but I have cautioned that git reset --hard is really the
way to do it.  Is there a difference here, or are they equivalent?


Bill
