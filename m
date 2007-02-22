From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix 'git commit -a' in a newly initialized repository
Date: Thu, 22 Feb 2007 22:13:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702222213120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070222202812.8882.44375.stgit@c165>
 <Pine.LNX.4.63.0702222140360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702221550290.27932@xanadu.home>
 <Pine.LNX.4.63.0702222157000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702221605080.27932@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Feb 22 22:13:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKLG3-0002N4-FL
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 22:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbXBVVNk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 16:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbXBVVNk
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 16:13:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:53316 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751900AbXBVVNj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 16:13:39 -0500
Received: (qmail invoked by alias); 22 Feb 2007 21:13:38 -0000
X-Provags-ID: V01U2FsdGVkX1/81OJlye78xE/X2VRJeT//WL0xKtyyKM/pubXGFC
	OGLw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <alpine.LRH.0.82.0702221605080.27932@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40394>

Hi,

On Thu, 22 Feb 2007, Nicolas Pitre wrote:

> On Thu, 22 Feb 2007, Johannes Schindelin wrote:
> 
> > I wanted to get at the "." thing. You know, when I start a project 
> > with git, there are usually some files there already. Provided I have 
> > a .gitignore there, I can just say "git add ." and be done.
> > 
> > But maybe that is _not_ common practice?
> 
> Well... If you're that acquainted with GIT to perform the above, I'm 
> sure a message like "use "git add file1 file2" to include for commit" 
> won't leave you puzzled.  ;-)

;-) Yes, you are right!

Ciao,
Dscho
