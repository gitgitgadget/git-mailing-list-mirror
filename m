From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW binary installer available
Date: Thu, 8 Feb 2007 21:08:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702082106430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45C9E470.7030609@xs4all.nl>
 <Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45CA4E68.6070308@xs4all.nl> <Pine.LNX.4.63.0702080051420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <87abzoh15n.fsf@peder.flower>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
To: Jan Nieuwenhuizen <janneke@gnu.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 21:08:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFFZV-0001V6-QV
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 21:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423300AbXBHUIl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 15:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423302AbXBHUIl
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 15:08:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:46728 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423300AbXBHUIk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 15:08:40 -0500
Received: (qmail invoked by alias); 08 Feb 2007 20:08:39 -0000
X-Provags-ID: V01U2FsdGVkX1/77QgZEh37Dbg7MmgGrKSCTmkq6j6uD2HowKUC50
	A30Q==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <87abzoh15n.fsf@peder.flower>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39084>

Hi,

On Thu, 8 Feb 2007, Jan Nieuwenhuizen wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >  http://lilypond.org/git/binaries/mingw/git-1.4.9993-2.mingw.exe
> 
> Yes, much better.  There's still the bash script problem, maybe
> these should be replaced with python?

Hahahaha!

This is not meant as laughing _about_ you... Along with others, I worked 
very hard to get rid of that naughty dependency to Python.

IMHO the best way for Git is to go builtin. It is the only way to 
guarantee portability to many, many platforms without a dependency 
nightmare.

Who knows, maybe Git will run on VMS yet?

Ciao,
Dscho
