From: jhapk <pradeep.kumar.jha@gmail.com>
Subject: Deleting remote branches
Date: Sat, 19 Jun 2010 11:17:51 -0700 (PDT)
Message-ID: <1276971471250-5199192.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 19 20:18:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQ2cD-0000en-7R
	for gcvg-git-2@lo.gmane.org; Sat, 19 Jun 2010 20:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756613Ab0FSSRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jun 2010 14:17:52 -0400
Received: from kuber.nabble.com ([216.139.236.158]:57119 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756489Ab0FSSRv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jun 2010 14:17:51 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <pradeep.kumar.jha@gmail.com>)
	id 1OQ2c3-0000n2-8H
	for git@vger.kernel.org; Sat, 19 Jun 2010 11:17:51 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149387>


Hi,

I added a remote called PCM to my repository. So when I do a 
$git branch -a

It shows me all the branches of the remote. I decided I don't want the
remote anymore, so I deleted it from my .git/config file and did
$git remote update

The first command verified that PCM is not a remote anymore, but still when
I do a $git branch -a,  I see all the branches of PCM.

How do I get rid of it?

Thanks
 
-- 
View this message in context: http://git.661346.n2.nabble.com/Deleting-remote-branches-tp5199192p5199192.html
Sent from the git mailing list archive at Nabble.com.
