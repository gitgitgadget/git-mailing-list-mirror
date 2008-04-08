From: Ittay Dror <ittayd@tikalk.com>
Subject: question about git and remote repositories
Date: Tue, 08 Apr 2008 22:08:57 +0300
Message-ID: <47FBC2C9.6060702@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 21:16:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjJJ4-0008GD-29
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 21:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbYDHTPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 15:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752295AbYDHTPs
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 15:15:48 -0400
Received: from smtp100.biz.mail.re2.yahoo.com ([206.190.52.46]:22200 "HELO
	smtp100.biz.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751968AbYDHTPs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Apr 2008 15:15:48 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Apr 2008 15:15:47 EDT
Received: (qmail 32400 invoked from network); 8 Apr 2008 19:09:07 -0000
Received: from unknown (HELO ?192.168.1.9?) (ittayd@tikalk.com@84.108.89.36 with plain)
  by smtp100.biz.mail.re2.yahoo.com with SMTP; 8 Apr 2008 19:09:06 -0000
X-YMail-OSG: yMR2IG4VM1nxte5ZOnd9LwUfTTUr4iO_nDafxUg4ZLbhzeJ1vHkvKi5MJTkqqpcO5C0LRC0RuY8YAgRJ_TDDi0R4F.x91VmGlnBqX5oVPiFJB.q3OEY-
X-Yahoo-Newman-Property: ymail-3
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79019>

Hi,

If I want to start working on a project that uses git (and I want to use 
git also), I first need to clone the project's repo. That is very slow 
(using the git:// protocol). Are there alternatives? For example, as far 
as I understand, if all I want is to get the latest commit in HEAD, 
branch from it and start working, then all git really needs to have is 
all objects referenced from that commit (commit, trees, blobs) and 
that's it, right? (as long as I don't expect to see full log of past 
operations)

Thanks,
Ittay

-- 
Ittay Dror <ittayd@tikalk.com>
Tikal <http://www.tikalk.com>
Tikal Project <http://tikal.sourceforge.net>
