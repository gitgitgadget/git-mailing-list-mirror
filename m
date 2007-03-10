From: Raimund Bauer <ray007@gmx.net>
Subject: Re: git-cvsimport: all my files are marked deleted ?
Date: Sat, 10 Mar 2007 19:51:33 +0100
Message-ID: <1173552693.5975.13.camel@localhost>
References: <200703101809.l2AI9lin005409@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Xavier Maillard <zedek@gnu.org>
X-From: git-owner@vger.kernel.org Sat Mar 10 19:51:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ6fb-0001Uv-LI
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 19:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbXCJSvi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 13:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbXCJSvi
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 13:51:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:54925 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751288AbXCJSvh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 13:51:37 -0500
Received: (qmail invoked by alias); 10 Mar 2007 18:51:35 -0000
Received: from p549892FC.dip0.t-ipconnect.de (EHLO [192.168.178.22]) [84.152.146.252]
  by mail.gmx.net (mp045) with SMTP; 10 Mar 2007 19:51:35 +0100
X-Authenticated: #20693823
X-Provags-ID: V01U2FsdGVkX19dB1l3wkhdL56tyYxWBvHn0wCZ2S88fJU9SBC8Vm
	CspCmB/s5G4FuD
In-Reply-To: <200703101809.l2AI9lin005409@localhost.localdomain>
X-Mailer: Evolution 2.8.1 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41876>

On Sat, 2007-03-10 at 19:09 +0100, Xavier Maillard wrote:
> Then I went back to <directory> and I just did 'ls'. Directory is
> empty (except the .git directory).

'git checkout -f' is your friend here.

Not long ago I was wondering about the same thing ...

-- 
best regards

  Ray
