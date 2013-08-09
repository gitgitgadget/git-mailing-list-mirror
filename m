From: Kevin Layer <layer@known.net>
Subject: post-rewrite hook doesn't run
Date: Fri, 09 Aug 2013 08:14:08 -0700
Message-ID: <24317.1376061248@tines.known.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 09 17:47:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7ouT-0002l4-PO
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 17:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967979Ab3HIPrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 11:47:21 -0400
Received: from relay.known.net ([173.13.135.57]:33185 "EHLO tines.known.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965274Ab3HIPrV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 11:47:21 -0400
Received: from tines.known.net (localhost [127.0.0.1]) by tines.known.net
    (Allegro Maild v1.2.32) id 000000007274; Fri, 9 Aug 2013 08:14:08 -0700
X-Mailer: MH-E 8.5; nmh 1.5; GNU Emacs 24.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231990>

for "git pull --rebase".  I see it run when I do "git rebase -i ...".

Is this a bug or feature?  It's with git version 1.7.11.7.
