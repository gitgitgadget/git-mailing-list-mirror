From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Commit ID in exported Tar Ball
Date: Thu, 17 May 2007 18:38:03 +0200
Message-ID: <20070517163803.GE4095@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
X-From: git-owner@vger.kernel.org Thu May 17 18:38:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoizU-0000iY-KD
	for gcvg-git@gmane.org; Thu, 17 May 2007 18:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443AbXEQQiG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 12:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755737AbXEQQiG
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 12:38:06 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:63389 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755443AbXEQQiF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 May 2007 12:38:05 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 4A3473F2F7; Thu, 17 May 2007 18:38:03 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47537>

Hello,
Michae, a friend of mine, is in the phase of migrating from git to cvs.
He releases tar balls of his software project using gitweb. He would
love to have a way to have the commit-id of HEAD of the export contained
in one of the files he exported that way. Is there infrastructure in git
that makes that already possible or does he need to some kind of
gerneration tool by himself? Maybe it would be helpful if the
git-tar-tree would generate a file .commitid or something like that in
the generated tar tree.

        Thomas
