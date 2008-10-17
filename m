From: Erik Hahn <erik_hahn@gmx.de>
Subject: Excluding files from git-diff
Date: Fri, 17 Oct 2008 16:53:13 +0200
Message-ID: <20081017145313.GA23471@eriks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 17 16:54:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqqij-0006LD-TA
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 16:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676AbYJQOxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 10:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754668AbYJQOxR
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 10:53:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:47834 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754512AbYJQOxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 10:53:16 -0400
Received: (qmail invoked by alias); 17 Oct 2008 14:53:14 -0000
Received: from p549ECEE6.dip.t-dialin.net (EHLO localhost) [84.158.206.230]
  by mail.gmx.net (mp058) with SMTP; 17 Oct 2008 16:53:14 +0200
X-Authenticated: #43117208
X-Provags-ID: V01U2FsdGVkX1/MrRA1ATjMUegxKO8tOtKCiIneJu4WPUAFMJPAyW
	8iE5hHszTrgMbq
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98480>

I'm currently working on a script whose developer does not use
git. Hence, when I mail him the patch, I don't want to include the
.gitignore file. Is it possible to exclude a file from git-diff (except
not adding it to git, of course?)

	-Erik

-- 
hackerkey://v4sw5hw2ln3pr5ck0ma2u7LwXm4l7Gi2e2t4b7Ken4/7a16s0r1p-5.62/-6.56g5OR
