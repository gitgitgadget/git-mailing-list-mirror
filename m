From: arttuladhar <aayush.tuladhar@gmail.com>
Subject: git-citool
Date: Fri, 10 Feb 2012 09:54:40 -0800 (PST)
Message-ID: <1328896480094-7273576.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 18:54:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvugI-0001LQ-67
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 18:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021Ab2BJRyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 12:54:41 -0500
Received: from sam.nabble.com ([216.139.236.26]:38530 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852Ab2BJRyk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 12:54:40 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <aayush.tuladhar@gmail.com>)
	id 1RvugC-0003KY-3P
	for git@vger.kernel.org; Fri, 10 Feb 2012 09:54:40 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190426>

When I perform commit in /git-citoo/l, the git hooks doesn't run. But for the
same repository, git hooks runs fine while using 
command line git commit -a.

I wanted to get template enforcement on the /git-citool/.

Anybody have idea on recompiling the git-gui from which git-citool gets run.
I know the git-gui is built on tcl and i have the source code but i have no
experience with tck and the recompile.

Thanks,
ART 

--
View this message in context: http://git.661346.n2.nabble.com/git-citool-tp7273576p7273576.html
Sent from the git mailing list archive at Nabble.com.
