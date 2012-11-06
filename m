From: Josef Wolf <jw@raven.inka.de>
Subject: Rebasing published branches?
Date: Tue, 6 Nov 2012 21:18:22 +0100
Message-ID: <20121106201822.GE28437@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 21:19:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVpcc-0002mc-UC
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 21:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138Ab2KFUT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 15:19:28 -0500
Received: from quechua.inka.de ([193.197.184.2]:45465 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115Ab2KFUTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 15:19:25 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1TVpcJ-0007tQ-Vy; Tue, 06 Nov 2012 21:19:23 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 34522760DF; Tue,  6 Nov 2012 21:18:23 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209117>

Hello,

I know, I should never rebase published branches. But...

I frequently work on different computers and would like to share my private
branches across them. When done and the feature is in a good shape, I'd like
to rebase to clean up history before I make it available to other people.

I guess rebasing such branches would be OK as long as I can reliably remember
to delete those branches on _all_ the clones I ever created.

But waht if I ever make a mistake? How would one recover from such rebase
disasters? Anybody knows a good description how such a recover would be done?
