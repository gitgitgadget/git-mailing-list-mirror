From: "Raimund Bauer" <ray007@gmx.net>
Subject: Problems with git cvsimport
Date: Tue, 27 Feb 2007 12:13:35 +0100
Message-ID: <001f01c75a60$53443e10$0b0aa8c0@abf.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 12:13:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM0H8-0006kX-Ap
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 12:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbXB0LNj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 06:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932997AbXB0LNj
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 06:13:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:50469 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932184AbXB0LNi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 06:13:38 -0500
Received: (qmail invoked by alias); 27 Feb 2007 11:13:36 -0000
X-Provags-ID: V01U2FsdGVkX1+j11hfv6WjhxqH7B29bJK6i49RWpX15wNCSPIf3c
	Yjmw==
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Importance: Normal
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40710>

When trying to cvsimport a project into git, I get an error from cvsps:

bad usage: invalid argument -A

Usage: cvsps [-h] [-x] [-u] [-z <fuzz>] [-g] [-s <range>[,<range>]]
             [-a <author>] [-f <file>] [-d <date1> [-d <date2>]]
             [-b <branch>]  [-l <regex>] [-r <tag> [-r <tag>]]
             [-p <directory>] [-v] [-t] [--norc] [--summary-first]
             [--test-log <captured cvs log file>] [--bkcvs]
             [--no-rlog] [--diff-opts <option string>] [--cvs-direct]
             [--debuglvl <bitmask>] [-Z <compression>] [--root <cvsroot>]
             [<repository>] [-q]

<-- cut option explanation -->

There is cvsps version 2.0rc1 installed on our server (a Suse 9.3 I
believe),
and using git version 1.5.0.2.775.g1a500 (next from a few minutes ago).

Many thanx in advance for any hints on how to make this work

-- 
best regards

  Ray
