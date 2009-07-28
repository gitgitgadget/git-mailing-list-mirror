From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3 v2] Improve your performance with our patch
Date: Tue, 28 Jul 2009 13:11:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907281307380.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0907280131230.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jul 28 13:11:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVkaV-0001Rs-Il
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 13:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbZG1LLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 07:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752417AbZG1LLJ
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 07:11:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:54474 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752366AbZG1LLI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 07:11:08 -0400
Received: (qmail invoked by alias); 28 Jul 2009 11:11:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 28 Jul 2009 13:11:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+qcMoHZleqAJq+1xwtfreTfuXAZgQXW2BlLkpU7x
	0i59sJDpqROVP3
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0907280131230.2147@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124236>

Hi,

On Tue, 28 Jul 2009, Daniel Barkalow wrote:

>  Documentation/git-shim.txt           |   37 +++++++++

May I re-register my complaint about the naming?

I mean, yes, I could think of something even worse when it comes to the 
(ridiculously bad!) tradition of naming things "porcelain", "plumbing" and 
"potty", especially when it comes to "pushing objects" and 
then "pulling".

But now that we had a good laugh, it is time to get serious again, and 
give this child a _way_ better name.

I mean, you already had a good name for your foreign scm series.  Why did 
you give that up in favor of this lousy naming?

Ciao,
Dscho
