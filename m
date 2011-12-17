From: hs_glw <greg@hra.net>
Subject: Big Mess--How to use Git to resolve
Date: Sat, 17 Dec 2011 04:32:10 -0800 (PST)
Message-ID: <1324125130643-7103964.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 13:32:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbtRJ-0000I7-E2
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 13:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140Ab1LQMcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 07:32:12 -0500
Received: from sam.nabble.com ([216.139.236.26]:51592 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073Ab1LQMcL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 07:32:11 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <greg@hra.net>)
	id 1RbtQw-0000CV-LW
	for git@vger.kernel.org; Sat, 17 Dec 2011 04:32:10 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187381>

I want to use Git, I have had read documentation installed on my local
machine, then looked at my mess of code and don't know what the hell to do.

I have a Perl Web Application, several hundred programs, templates,
configuration files.

Companies buy my application and I host it for them.

I have 40+ clients

Each client has its own unique installation of the software on my web
server.

Some clients have customizations of the code, some have version 5 of the
software others have 5.2, 5.5 etc.

This sucks.

My goal is to pull all the different versions in, put them all together, and
create a master version of the software that runs for all clients.

There will still be some files that are completely unique to each client
(style sheets and logos for instance).

I can't figure out if I should start with my oldest version of the code or
the newest, I haven't really found in the documentation how to start with
different permutations of the code in a repository.   Everything I have
found assumes you start with one set of code, then make changes.  I have
multiple variations and need to get them consistent.

I expect to use all of 2012 getting this put back together, but I have to
start.  Does anyone have any suggestions on how I should set Git up to do
what I need?

--
View this message in context: http://git.661346.n2.nabble.com/Big-Mess-How-to-use-Git-to-resolve-tp7103964p7103964.html
Sent from the git mailing list archive at Nabble.com.
