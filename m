From: Rick Bragg <lists@gmnet.net>
Subject: {Spam?} push pull not working
Date: Tue, 24 Jan 2012 14:00:31 -0500
Message-ID: <1327431631.21582.209.camel@thor>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 24 20:10:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpllO-0002UF-KP
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 20:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633Ab2AXTKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 14:10:34 -0500
Received: from smtp.gmnet.net ([207.136.225.2]:49432 "EHLO smtp.gmnet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752166Ab2AXTKd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 14:10:33 -0500
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jan 2012 14:10:33 EST
MailScanner-NULL-Check: 1328036297.85395@d12eYQ/cbuZGbkDSfKKo0A
Received: from [192.168.1.36] (pool-70-109-163-238.cncdnh.east.myfairpoint.net [70.109.163.238])
	(authenticated bits=0)
	by smtp.gmnet.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id q0OIwEnc009700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 24 Jan 2012 13:58:16 -0500
X-Mailer: Evolution 2.28.3 
X-MailScanner-ID: q0OIwEnc009700
X-GreenMountainNetwork-MailScanner: Found to be clean
X-GreenMountainNetwork-MailScanner-From: lists@gmnet.net
X-Spam-Status: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189057>

Hi,

I cloned a repo from /home/me/repo1 to /home/me/repo2.  Then made
changes and a new commit on repo1, then from repo1 did "git
push /home/me/repo2 and it says Everything is up-to-date.  How could
this be?

Thanks
Rick
