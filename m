From: james_68 <james.marxista@gmail.com>
Subject: update kernel with git
Date: Tue, 2 Feb 2010 12:47:37 -0800 (PST)
Message-ID: <1265143657343-4503539.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 21:47:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcPey-0005Ko-EH
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 21:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037Ab0BBUri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 15:47:38 -0500
Received: from kuber.nabble.com ([216.139.236.158]:39434 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755164Ab0BBUrh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 15:47:37 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <james.marxista@gmail.com>)
	id 1NcPer-0007nx-BK
	for git@vger.kernel.org; Tue, 02 Feb 2010 12:47:37 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138752>


Hi, In my git repository I have a linux kernel 2.6.31 with a branch, I have
to update master branch to 2.6.32.7. 
I tried git pull path_2.6.32 master but it doesn't run, it does some
computation and then it says:
......
walk df56cb1f37415f16a187738ee9e3c03e2106e305
From http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.32.y
 * branch            master     -> FETCH_HEAD
error: Entry '.gitignore' not uptodate. Cannot merge.
fatal: merging of trees 44927d86ace5c502486e26ed828a02fea9627119 and
84637ae413afcb236f0e9060e03cdec9fa017b0b failed

The question is: Is it the correct way execute git pull .... to update my
2.6.31 git kernel?

Thanks
Bye

-- 
View this message in context: http://n2.nabble.com/update-kernel-with-git-tp4503539p4503539.html
Sent from the git mailing list archive at Nabble.com.
