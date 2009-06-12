From: Jeff Garzik <jeff@garzik.org>
Subject: [bug] git cannot find "git pull"?
Date: Thu, 11 Jun 2009 20:10:09 -0400
Message-ID: <4A319CE1.6040201@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 12 02:10:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEuLe-00080Y-BH
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 02:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760795AbZFLAKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 20:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759126AbZFLAKL
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 20:10:11 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:48109 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757486AbZFLAKK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 20:10:10 -0400
Received: from cpe-069-134-158-197.nc.res.rr.com ([69.134.158.197] helo=bd.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1MEuLT-0006sz-TV
	for git@vger.kernel.org; Fri, 12 Jun 2009 00:10:12 +0000
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.5 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121380>


I just upgraded to Fedora 11 (git-1.6.2.2-1.fc11.x86_64), and see the 
following:

> [jgarzik@viper linux-2.6]$ git pull
> git: 'pull' is not a git-command. See 'git --help'.
> 
> Did you mean this?
> 	shell


Bleh...  :)  "git --help" indicates that "git pull" still exists.

	Jeff
