From: jhapk <pradeep.kumar.jha@gmail.com>
Subject: Tracking selected files from different repository
Date: Sat, 19 Jun 2010 11:12:20 -0700 (PDT)
Message-ID: <1276971140188-5199181.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 19 20:12:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQ2Wp-0006fg-7B
	for gcvg-git-2@lo.gmane.org; Sat, 19 Jun 2010 20:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756575Ab0FSSMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jun 2010 14:12:21 -0400
Received: from kuber.nabble.com ([216.139.236.158]:36384 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756356Ab0FSSMU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jun 2010 14:12:20 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <pradeep.kumar.jha@gmail.com>)
	id 1OQ2Wi-0000Q0-6H
	for git@vger.kernel.org; Sat, 19 Jun 2010 11:12:20 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149386>


Hi,

I have a source code in a repository A. A has 1000s of files.  In A, I have
added like 10 new files. For some reasons, I work on these 10 files in a
different repository B. Is it somehow possible that I can make only these 10
files pull and push easily from my repository B? There is nothing else
common between A and B, so I am not sure if putting B as a remote and making
a branch in A to track it is a feasible idea.

Thanks
Pradeep
-- 
View this message in context: http://git.661346.n2.nabble.com/Tracking-selected-files-from-different-repository-tp5199181p5199181.html
Sent from the git mailing list archive at Nabble.com.
