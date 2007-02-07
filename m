From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW binary installer available
Date: Thu, 8 Feb 2007 00:52:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702080051420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45C9E470.7030609@xs4all.nl>
 <Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45CA4E68.6070308@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jan Nieuwenhuizen <janneke@gnu.org>
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Feb 08 00:52:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEwan-0005ba-VB
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 00:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422800AbXBGXwa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 18:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422813AbXBGXwa
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 18:52:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:51113 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422800AbXBGXw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 18:52:29 -0500
Received: (qmail invoked by alias); 07 Feb 2007 23:52:28 -0000
X-Provags-ID: V01U2FsdGVkX19+Yb0LS4B+jW5kOnfDC0WahJ8gRciPn352zicnd/
	roXg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45CA4E68.6070308@xs4all.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39005>

Hi,

On Wed, 7 Feb 2007, Han-Wen Nienhuys wrote:

> Johannes Schindelin escreveu:
> > I played a little with it. IMHO it makes no sense to use it without a 
> > bash, and without less. For example,
> > 
> > 	$ git init
> > 	$ git add git.exe
> > 	$ git status
> > 	$ git commit -a -m initial
> > 	$ git show HEAD
> > 
> > do not produce any output when issued in cmd.
> 
> can you check out the -2 build, at 
>  
>   http://lilypond.org/git/binaries/mingw/git-1.4.9993-2.mingw.exe
>   
> to see if this is better?

Unfortunately, today was the last day for me at a company where I have 
access to Losedows. I'll try to get hold of another machine, and try 
there, though.

Ciao,
Dscho
