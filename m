From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: GIT on MinGW problem
Date: Sun, 27 May 2007 17:44:44 -0300
Message-ID: <4659EDBC.7080804@xs4all.nl>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <Pine.LNX.4.64.0705251113280.4648@racer.site> <46588DA4.5020109@xs4all.nl> <Pine.LNX.4.64.0705262311380.4648@racer.site>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <J.Sixt@eudaptics.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 22:47:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsPdq-0005j5-TB
	for gcvg-git@gmane.org; Sun, 27 May 2007 22:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbXE0UrA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 16:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754824AbXE0UrA
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 16:47:00 -0400
Received: from main.gmane.org ([80.91.229.2]:57180 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753571AbXE0Uq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 16:46:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HsPde-0004M6-Ps
	for git@vger.kernel.org; Sun, 27 May 2007 22:46:54 +0200
Received: from c911deb6.bhz.virtua.com.br ([201.17.222.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 May 2007 22:46:54 +0200
Received: from hanwen by c911deb6.bhz.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 May 2007 22:46:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c911deb6.bhz.virtua.com.br
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <Pine.LNX.4.64.0705262311380.4648@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48579>

Johannes Schindelin escreveu:
> There's a bash src in the Snapshot package of MinGW:
> 
> 	http://prdownloads.sf.net/mingw/bash-2.05b-MSYS-src.tar.bz2?download

this thoroughly confuses me. 

Does it require MSYS? If yes, where can I find the MSYS source code?

What does it mean that: 

However, it is important to remember that NO executables other than
what ships with MSYS should be placed in the MSYS " bin"
subdirectory. Therefore, do not attempt to "merge" the two packages.
(http://www.mingw.org/mingwfaq.shtml#faq-msys)

If this is true, this will mess up my installers.


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
