From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: correct git merge behavior or corner case?
Date: Mon, 20 Apr 2009 11:49:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904201148150.6955@intel-tinevez-2-302>
References: <4ac8254d0904191540j68246cd8qa36a034209d4c800@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 11:51:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvqA4-0005Iq-DL
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 11:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862AbZDTJuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 05:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753775AbZDTJuB
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 05:50:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:55817 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753542AbZDTJuA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 05:50:00 -0400
Received: (qmail invoked by alias); 20 Apr 2009 09:49:57 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 20 Apr 2009 11:49:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+gaCxxqM2gwDPRNb+5zH/Vr6oalPkmWpk44a/Rfw
	0LOQD0MiXj2xfQ
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4ac8254d0904191540j68246cd8qa36a034209d4c800@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116954>

Hi,

On Mon, 20 Apr 2009, Tuncer Ayaz wrote:

> I have stumbled upon the following blog post via one of the news 
> aggegrators and wondered whether the behavior is correct and expected or 
> he's expecting something wrong or doing something wrong.
> 
> I cannot see a wrong usage pattern from what he has written.
> 
> http://blog.teksol.info/2009/04/15/beware-of-gits-content-tracking.html
> 
> as the author hasn't posted here after a couple of days I decided to 
> take his question here for at least understanding what behavior he is 
> experiencing.

First, a blog posting is a lousy place to post complaints.  That just 
decreased my confidence level in the competence of Francois.

Second, he does not state what he expects to see instead.  And for the 
love of God, I cannot see what should be wrong in the output he gets.  
Another few notches down.

Ciao,
Dscho
