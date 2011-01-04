From: bolfo <boflor@gmail.com>
Subject: weird github capitalization problem
Date: Tue, 4 Jan 2011 05:04:02 -0800 (PST)
Message-ID: <1294146242606-5888573.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 04 14:26:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pa6tl-0003f1-7m
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 14:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100Ab1ADNZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 08:25:54 -0500
Received: from sam.nabble.com ([216.139.236.26]:38874 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983Ab1ADNZx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 08:25:53 -0500
X-Greylist: delayed 1310 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2011 08:25:53 EST
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <boflor@gmail.com>)
	id 1Pa6YU-0003N3-Jn
	for git@vger.kernel.org; Tue, 04 Jan 2011 05:04:02 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164491>


Hello guys,

I am new at git and github, but I am collaborating on a netbeans java
project with someone else and we host our code on github.
I first installed everything on my laptop, coded some stuff and then pushed
to github. Apparently something went wrong because there was a new
directory, while at first the directory was OurProjectsources, there now was
a new directory called OurProjectSources. Weird since my local directory has
the s not capitalized.
I installed git on another PC and cloned the project from github to my local
PC.
Apparently only the directory with the capital S was pulled.

Does anyone recognize this problem? 
I work on a windows PC while the original author works on a Mac, could this
be the problem?
-- 
View this message in context: http://git.661346.n2.nabble.com/weird-github-capitalization-problem-tp5888573p5888573.html
Sent from the git mailing list archive at Nabble.com.
