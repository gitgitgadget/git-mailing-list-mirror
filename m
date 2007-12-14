From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Funky] "git -p cmd" inside a bare repository
Date: Fri, 14 Dec 2007 20:37:15 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712142036290.27959@racer.site>
References: <20071129122139.GA11176@laptop> <7vmysexdvw.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712141943280.27959@racer.site> <7vejdpqbbh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-21559708-1197664635=:27959"
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 21:37:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3HI4-00048t-He
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 21:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbXLNUh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 15:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753683AbXLNUh0
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 15:37:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:36772 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753113AbXLNUhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 15:37:25 -0500
Received: (qmail invoked by alias); 14 Dec 2007 20:37:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp019) with SMTP; 14 Dec 2007 21:37:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19mMFtpfnVmSAKIL2RdorY0dgHFCmO8UVXL9g1jzq
	fPWJ1OmKBs5h57
X-X-Sender: gene099@racer.site
In-Reply-To: <7vejdpqbbh.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68344>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-21559708-1197664635=:27959
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 14 Dec 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I have no time left to work on git for a few days, so I cannot even 
> > review your patch.  But Jeff's patch being smaller, I could, and 
> > AFAICT it solves the problem.
> 
> We have more than a few days ;-) Hope you are feeling better now.
> 
> You got familialized yourself with the work-tree part because the 
> initial round was so broken and you had to step in during the last round 
> (unfortuantely ;-), and Nguyễn also is familiar with that part of the 
> code.  It would be nice if we can have a proper fix that is not papering 
> over deeper breakage.

Like always, you are correct.

Will look into it over the weekend (although I will only be able to report 
back on Monday, due to the wonderful administrators who broke my internet 
connection at home).

Ciao,
Dscho

---1463811741-21559708-1197664635=:27959--
