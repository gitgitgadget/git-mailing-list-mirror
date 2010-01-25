From: habilis <nicoloubser@gmail.com>
Subject: git not adding subdirectories to repository on Windows
Date: Sun, 24 Jan 2010 23:39:40 -0800 (PST)
Message-ID: <1264405180785-4452655.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 25 08:39:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZJYE-0004J9-7H
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 08:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398Ab0AYHjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 02:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938Ab0AYHjm
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 02:39:42 -0500
Received: from kuber.nabble.com ([216.139.236.158]:44772 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab0AYHjl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 02:39:41 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1NZJXw-0004au-Pc
	for git@vger.kernel.org; Sun, 24 Jan 2010 23:39:40 -0800
X-Nabble-From: habilis <nicoloubser@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137940>


Hi

I am using netbeans 6.7 with nbgit 0.3 and PHP plugins, on Windows XP. 

I create my project in Netbeans, and then initialises git. All the files in
my root directory can by added and committed to my repository, but not any
files in my subfolders. The 'commit' option is greyed out on any files in
subfolders. This happens regardless of whether I added the subdirectory
before or after initialising git, and regardless any editing and saving I do
with files in subdirectories.

Initialising and adding files to the repository via the bash shell picks up
that I edited files in a subdirectory, but, Netbeans still doesnt pick up
the files have been changed, and no history is available.

Status, and Update links on the menu is active, but diff and commit stays
greyed out.

Anyone knows how to fix this?

Thank you


-- 
View this message in context: http://n2.nabble.com/git-not-adding-subdirectories-to-repository-on-Windows-tp4452655p4452655.html
Sent from the git mailing list archive at Nabble.com.
