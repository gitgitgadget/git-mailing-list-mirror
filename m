From: Bill Lear <rael@zopyra.com>
Subject: How to change merge message ("weenie commits")
Date: Thu, 25 Jan 2007 09:56:33 -0600
Message-ID: <17848.54065.631799.755255@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 25 16:56:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA6xs-0005Qk-EG
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 16:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbXAYP4h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 10:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbXAYP4h
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 10:56:37 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60552 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030243AbXAYP4g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 10:56:36 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0PFuaC22933;
	Thu, 25 Jan 2007 09:56:36 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37730>

I have developed a habit of using my SCM to provide local backup of my
daily (hourly) work.  I often will work to a stopping point and commit
my work, without any real coherence to the commit --- a sort of
checkpoint.  These I call "weenie commits" because they are weenie-ish,
unimportant in the larger scheme of things.

When developing with others, I would like to be able to work in this
way, tidily keeping my stuff tucked away in my SCM system, and then
when I am ready to share, to convey to my peers what they need to
know about my work, and not the 10,000 weenie commit messages that
may be associated with my work.

So, when I merge my topic branch onto master, for example, I'd like
the commit message to be something more thoughtful than the
"checkpoint 1", "checkpoint 2", "fix typo", "redo sort algorithm",
etc., etc., and be more like a short set of release notes, a summary
of what all has been accomplished.

Do others run into this and perhaps have a good solution?


Bill
