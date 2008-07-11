From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Should we discuss Windows-related changes on
 git@vger.kernel.org?
Date: Fri, 11 Jul 2008 13:56:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807111349470.3640@eeepc-johanness>
References: <DDFD7E3B-8401-4EA0-9BBA-C9D8E25998A3@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 13:57:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHHFf-0000R5-4I
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 13:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738AbYGKL43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 07:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753921AbYGKL43
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 07:56:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:39107 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753685AbYGKL42 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 07:56:28 -0400
Received: (qmail invoked by alias); 11 Jul 2008 11:56:26 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp014) with SMTP; 11 Jul 2008 13:56:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Dhzo30ZzD09qulWSJLoMNoqSkrwaCLzrG88h1Qj
	7JfXf0yDsQKIdT
X-X-Sender: user@eeepc-johanness
In-Reply-To: <DDFD7E3B-8401-4EA0-9BBA-C9D8E25998A3@zib.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88109>

Hi,

On Fri, 11 Jul 2008, Steffen Prohaska wrote:

> I decided to stop queuing changes in 4msysgit.  Instead I'd like to
> bring the diff between Junio's and 4msysgit's master to zero.  This
> seems to be achievable after Junio merged Hannes' MinGW changes.
> 
> I think all Windows-related changes to the git code base could be
> discussed directly on the main git list and the msysgit list would be
> reserved for the MinGW/MSYS runtime environment and the installer.

I disagree.  Judging from the mails I read on the git list, Junio gets 
really swamped by patches these days (what with our very productive GSoC 
students).

I really think that we should discuss the patches on the msysGit list 
first, whip them into shape, and then send them off.

Just think of those patches that were sent off, only to realize that they 
were no longer needed.  That should not have happened.

My 2p,
Dscho
