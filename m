From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: GIT on MinGW problem
Date: Sat, 12 May 2007 00:30:54 -0300
Message-ID: <464534EE.30904@xs4all.nl>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <angray@beeb.net>
X-From: git-owner@vger.kernel.org Sat May 12 05:31:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmiKQ-0006xX-Qf
	for gcvg-git@gmane.org; Sat, 12 May 2007 05:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbXELDbX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 23:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbXELDbW
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 23:31:22 -0400
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:2923 "EHLO
	smtp-vbr11.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbXELDbW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 23:31:22 -0400
Received: from [192.168.1.100] (c911deb6.bhz.virtua.com.br [201.17.222.182])
	(authenticated bits=0)
	by smtp-vbr11.xs4all.nl (8.13.8/8.13.8) with ESMTP id l4C3VBAn088216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 12 May 2007 05:31:19 +0200 (CEST)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1dbc01c79432$b4400a80$0200a8c0@AMD2500>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47019>

Aaron Gray escreveu:
> Hello,
> 
> I have installed the git-1.5.1-1.mingw.exe from
> http://lilypond.org/git/binaries/mingw/.
> 
> On typing 'git' I get a message box saying :-
> 
>        The procedure entry point libiconv could not be located in the
> dynamic link library libiconv-2.dll.
> 
> I cannot seem to find libiconv-2.dll anywhere either.

This should be fixed in 

http://lilypond.org/git/binaries/mingw/git-1.5.1-2.mingw.exe

it should also set $PATH.

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
