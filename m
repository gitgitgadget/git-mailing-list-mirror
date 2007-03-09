From: Raimund Bauer <ray007@gmx.net>
Subject: Problems with autoCRLF?
Date: Fri, 09 Mar 2007 19:15:02 +0100
Message-ID: <1173464102.6102.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 09 19:15:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPjcW-0002X8-Dk
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 19:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbXCISPG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 13:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752697AbXCISPG
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 13:15:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:40864 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751722AbXCISPF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 13:15:05 -0500
Received: (qmail invoked by alias); 09 Mar 2007 18:15:03 -0000
Received: from p54988720.dip0.t-ipconnect.de (EHLO [192.168.178.22]) [84.152.135.32]
  by mail.gmx.net (mp048) with SMTP; 09 Mar 2007 19:15:03 +0100
X-Authenticated: #20693823
X-Provags-ID: V01U2FsdGVkX190lg1Rctt0NmLmXnhm1RbMPt6FMCe4Q7f+BQVGtk
	pSu2pgZ9IqBvaU
X-Mailer: Evolution 2.8.1 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41803>

Is it really intended that with a setting core.autoCRLF=true textfiles
are checked out with crlf-lineendings on linux-boxes?

I found out because the git-compilation broke ...

Now using core.autocrlf=input ;-)

-- 
best regards

  Ray
