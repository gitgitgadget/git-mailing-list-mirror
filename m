From: NewToGit <omarnetbox@gmail.com>
Subject: Applying the changes of a specific commit from one branch to
 another.
Date: Sun, 1 Mar 2009 17:44:04 -0800 (PST)
Message-ID: <22280717.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 02:45:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdxDu-0004qH-3C
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 02:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756973AbZCBBoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 20:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756728AbZCBBoI
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 20:44:08 -0500
Received: from kuber.nabble.com ([216.139.236.158]:46727 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756604AbZCBBoI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 20:44:08 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1LdxCO-0006ty-J5
	for git@vger.kernel.org; Sun, 01 Mar 2009 17:44:04 -0800
X-Nabble-From: omarnetbox@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111899>


Applying the changes of a specific commit from one branch to another.

Scenario:

- branched off master and created story123 branch.
- made three separate change commits to story123:
	- 'fixed bug123'
	- 'fixed bug456'
	- 'fixed bug789'

- now I realized that I need to apply only one commit 'fixed bug789' to
master

Question: What's the best way to go about doing this?

Thanks for the help!

NewToGit

-- 
View this message in context: http://www.nabble.com/Applying-the-changes-of-a-specific-commit-from-one-branch-to-another.-tp22280717p22280717.html
Sent from the git mailing list archive at Nabble.com.
