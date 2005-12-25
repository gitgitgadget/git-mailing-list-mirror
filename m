From: "Rob McDonald" <robm@asdl.gatech.edu>
Subject: Re: Possibility of a MinGW version?
Date: Sun, 25 Dec 2005 12:16:29 -0500
Message-ID: <003101c60976$f2912ff0$6900a8c0@sps>
References: <006c01c60832$86f92620$6900a8c0@sps> <43AD1E63.4040103@op5.se> <009701c60891$50893fd0$6900a8c0@sps> <Pine.LNX.4.63.0512241509240.24308@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 25 18:13:34 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqZR5-0001Q1-JA
	for gcvg-git@gmane.org; Sun, 25 Dec 2005 18:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbVLYRNL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Dec 2005 12:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbVLYRNK
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Dec 2005 12:13:10 -0500
Received: from sccrmhc14.comcast.net ([63.240.77.84]:15055 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750853AbVLYRNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Dec 2005 12:13:09 -0500
Received: from sps (c-24-98-112-64.hsd1.ga.comcast.net[24.98.112.64])
          by comcast.net (sccrmhc14) with SMTP
          id <200512251713080140032j25e>; Sun, 25 Dec 2005 17:13:09 +0000
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14049>

> Well, cygwin is everything but unmaintained. It's unfair to blaim the good
> work of the cygwin folks if you can't get it to work. I have *never* had a
> problem I could not solve with cygwin. In particular, *no* package got
> messed up when I installed/upgraded another package. Before you ask: I use
> cygwin extensively.

I'm sorry to have seemed harsh in my criticism.  I have not used Cygwin
seriously in a couple years.  At the time, as a user, I saw no noticable
progress.  The project seemed dead.  I always had trouble with their package
management program.  I'm glad you've never had similar problems.

> As I already stated, there are two *big* showstoppers when it comes to
> port git to MinGW.

Thanks very much for those comments, that is exactly the kind of information
I was hoping to get out of this thread.

> Okay, I'll bite. Could you please port python to MinGW?

As I said, my experience porting apps to MinGW has been very limited in
scope.  Essentially limited to programs that don't use any unixisms.  I see
no need to port Python, they already have a native version.  And, you could
always use Jython if they didn't.

> You're welcome. Just be sure to tackle the hard problems first, else you
> end up having wasted lots of valuable time for nothing.

Thanks for the insight.  I didn't think the shell and / vs \ were going to
be the real issues.

                 Rob
