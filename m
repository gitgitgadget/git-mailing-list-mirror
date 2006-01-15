From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: cvs-migration.txt
Date: Sun, 15 Jan 2006 14:58:04 -0500
Message-ID: <20060115195804.GD3985@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 15 20:58:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyE0w-00047I-NZ
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 20:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWAOT6H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 14:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWAOT6H
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 14:58:07 -0500
Received: from mail.fieldses.org ([66.93.2.214]:8334 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S932124AbWAOT6G (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jan 2006 14:58:06 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1EyE0q-0001tf-O3; Sun, 15 Jan 2006 14:58:04 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14704>

I find the following sentence from cvs-migration.txt slightly confusing:

	"The cut-off is date-based, so don't change the branches that
	were imported from CVS."

I assume the branches referrred to are the target git branches, not the
source CVS branches?  (And are date-based cut-offs really the essential
reason for this restriction?)

--b.
