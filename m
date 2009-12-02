From: GittyUser <xtelligence@gmail.com>
Subject: How to update from remote origin with local modified branch?
Date: Wed, 2 Dec 2009 03:22:34 -0800 (PST)
Message-ID: <1259752954810-4099323.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 12:22:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFnI9-00016i-5V
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 12:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbZLBLW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 06:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbZLBLW3
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 06:22:29 -0500
Received: from kuber.nabble.com ([216.139.236.158]:54861 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbZLBLW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 06:22:28 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1NFnI2-0002vD-QI
	for git@vger.kernel.org; Wed, 02 Dec 2009 03:22:34 -0800
X-Nabble-From: GittyUser <xtelligence@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134330>


I have once cloned a a project from a remote repository:
git cloned http://repo.or.cz/r/openbsc.git

After that I modified some files and commited.
In the mean time the remote repository had several commits. Now I want to
update my local repo from the remote repo but I also want to keep my own
commits. So, when doing "git pull" I get the message that certain files
needs to be updated.

Now, how can I get my local repo, with my own modification, updated by the
remote repo?
I know I need to be aware that those updates (or commits) from remote must
not conflict with my local.

Thank you.
-- 
View this message in context: http://n2.nabble.com/How-to-update-from-remote-origin-with-local-modified-branch-tp4099323p4099323.html
Sent from the git mailing list archive at Nabble.com.
