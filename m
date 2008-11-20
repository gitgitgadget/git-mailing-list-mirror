From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Whats happening with git-notes?
Date: Thu, 20 Nov 2008 14:12:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811201410320.30769@pacific.mpi-cbg.de>
References: <1227183162.23155.32.camel@vaio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tim Ansell <mithro@mithis.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 14:06:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L39Eb-0005DZ-UI
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 14:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659AbYKTNE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 08:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754413AbYKTNE6
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 08:04:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:54945 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751317AbYKTNE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 08:04:57 -0500
Received: (qmail invoked by alias); 20 Nov 2008 13:04:55 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 20 Nov 2008 14:04:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jG4Y1AsBja2NUGTkwamoT5YTMbhFghVxYjKe0Fp
	jmVG3YcqhbCvSF
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1227183162.23155.32.camel@vaio>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101418>

Hi,

On Thu, 20 Nov 2008, Tim Ansell wrote:

> I was just wondering what is happening with git notes stuff? I really 
> like the idea of being able to annotate commits with various 
> information.
> 
> After the gittogether it sounded like we had a solid proposal and
> possible implementation, has anything happened since then? I had a quick
> look over the archives but didn't seem much mention of them in the last
> couple of weeks.
> 
> Thanks for your help.
> 
> Tim 'mithro' Ansell
> PS I'm going to try harder to find the time to continue to work on the
> git-media cloning stuff, been a bit snowed under at work.

The same goes on here.  I wanted to take Peff's idea -- that hadn't 
occurred to me back when I tried to help Johan with his notes idea -- 
which is to read in the whole notes tree into a singleton when needed, and 
incorporate it into my existing test framework.

Maybe I'll find time later today.

Ciao,
Dscho
