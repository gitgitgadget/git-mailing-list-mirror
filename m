From: Steffen Prohaska <prohaska@zib.de>
Subject: Git-1.6.0.2-preview20080921 on Windows
Date: Sun, 21 Sep 2008 19:30:13 +0200
Message-ID: <82166911-C34F-439C-A2F3-CEBD7346A1D6@zib.de>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 21 19:31:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhSmO-0001EY-Qb
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 19:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbYIURaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 13:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbYIURaE
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 13:30:04 -0400
Received: from mailer.zib.de ([130.73.108.11]:60477 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733AbYIURaC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 13:30:02 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m8LHTr67014216;
	Sun, 21 Sep 2008 19:29:58 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db83fe5.pool.einsundeins.de [77.184.63.229])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m8LHTqGx028632
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 21 Sep 2008 19:29:53 +0200 (MEST)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96414>

Git-1.6.0.2-preview20080921 for Windows is available at

     http://code.google.com/p/msysgit/downloads

The version installed is based on Junio's current 'maint' (cc185a6a8a)
plus the patch series I sent today, see

    http://article.gmane.org/gmane.comp.version-control.git/92605

The new installer is not yet featured on the msysgit homepage, because
the installer contains the new "libexec/git-core" layout, which has not
been tested much.  I'll wait a few days to see if the new layout works.
If hear nothing bad, I'll move the "Featured" flag to 1.6.0.2.

	Steffen
