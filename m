From: git_user101 <m.aqadjanimemar@student.ru.nl>
Subject: Re: Error: Unable to append to logs/HEAD: Permission denied
Date: Mon, 17 May 2010 05:48:23 -0700 (PDT)
Message-ID: <1274100503553-5064900.post@n2.nabble.com>
References: <1274051912050-5063068.post@n2.nabble.com> <4BF0F63A.1080005@drmicha.warpmail.net> <1274084247216-5064104.post@n2.nabble.com> <4BF10623.5000705@drmicha.warpmail.net> <1274094574729-5064574.post@n2.nabble.com> <4BF12B11.2090002@drmicha.warpmail.net> <1274098383422-5064764.post@n2.nabble.com> <4BF135D8.70106@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 17 14:48:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODzkE-00048h-PS
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 14:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813Ab0EQMsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 08:48:25 -0400
Received: from kuber.nabble.com ([216.139.236.158]:48528 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747Ab0EQMsY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 08:48:24 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <m.aqadjanimemar@student.ru.nl>)
	id 1ODzk7-0008Lx-I3
	for git@vger.kernel.org; Mon, 17 May 2010 05:48:23 -0700
In-Reply-To: <4BF135D8.70106@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147232>


The push is succeed but I get this error every time. This is de complete
message:

user@desktop:~/Documents/LRSystems$ git push 
user@server's password: 
Counting objects: 5, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 302 bytes, done.
Total 3 (delta 2), reused 0 (delta 0)
To ssh://user@server:port/repositories/LRSystems
   1143c0..50b610  master -> master
error: failed to push some refs to
'ssh://user@server:port/repositories/LRSystems'
user@desktop:~/Documents/LRSystems$

As you can see the push is done but I get the error.
-- 
View this message in context: http://git.661346.n2.nabble.com/Error-Unable-to-append-to-logs-HEAD-Permission-denied-tp5063068p5064900.html
Sent from the git mailing list archive at Nabble.com.
