From: hogsolo <greg@localdirt.com>
Subject: How to diff between a file on a branch and a master.
Date: Thu, 9 Sep 2010 10:04:50 -0700 (PDT)
Message-ID: <1284051890085-5515312.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 09 19:04:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtkYS-0003JJ-Ho
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 19:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314Ab0IIREv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 13:04:51 -0400
Received: from kuber.nabble.com ([216.139.236.158]:58868 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab0IIREu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 13:04:50 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <greg@localdirt.com>)
	id 1OtkYM-0002Ea-2z
	for git@vger.kernel.org; Thu, 09 Sep 2010 10:04:50 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155865>


I've got a working file in my master, but I want to see what's different
about it on the branch.
I've seen how to diff the WHOLE branch and master, but not target a specific
file.
What's the syntax for that?

thanks
-- 
View this message in context: http://git.661346.n2.nabble.com/How-to-diff-between-a-file-on-a-branch-and-a-master-tp5515312p5515312.html
Sent from the git mailing list archive at Nabble.com.
