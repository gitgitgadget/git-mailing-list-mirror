From: Sri <nkf364@motorola.com>
Subject: compare log of two different repos
Date: Wed, 30 Mar 2011 12:49:16 -0700 (PDT)
Message-ID: <1301514556812-6224714.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 21:49:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q51OM-0006Uq-D3
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 21:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755734Ab1C3TtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 15:49:17 -0400
Received: from sam.nabble.com ([216.139.236.26]:60705 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754838Ab1C3TtR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 15:49:17 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <nkf364@motorola.com>)
	id 1Q51OG-0000pF-QP
	for git@vger.kernel.org; Wed, 30 Mar 2011 12:49:16 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170415>

Hi
This is my scenario:
-  Server has 2 different repos say x & y
- I created a branch out of x ( say xx) and a branch out of y (say yy)
- Now I made changes to xx/folder1/file1- change 1and commit it ;then I made
changes to to yy/folder1/file1 -change 1 and yy/folder1/file 1 -change 2 and
commit it ( Folder 1,file 1, change 1 are same in both xx and yy)
- Now I want the log of unique commits between both branches ( which will be
change 2 commit in yy)

How do I get this using GIT? Right now am doing it manually which is very
tedious...

Thanks
SS

--
View this message in context: http://git.661346.n2.nabble.com/compare-log-of-two-different-repos-tp6224714p6224714.html
Sent from the git mailing list archive at Nabble.com.
