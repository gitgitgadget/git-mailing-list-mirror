From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: GIT on MinGW, with tcltk for gitk
Date: Sun, 27 May 2007 19:28:44 -0300
Message-ID: <465A061C.7010803@xs4all.nl>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org> <4659D306.6030803@xs4all.nl> <f3cnm6$gda$1@sea.gmane.org> <00a601c7a09f$218c1020$0200a8c0@AMD2500> <4659F5D0.2070406@xs4all.nl> <00b901c7a0a5$77983420$0200a8c0@AMD2500> <00c401c7a0a7$8a5690a0$0200a8c0@AMD2500> <f329bf540705271455m4c0f5a55v14b9a8cc6bd7778d@mail.gmail.com> <00ef01c7a0ad$78508e00$0200a8c0@AMD2500>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Aaron Gray <angray@beeb.net>
X-From: git-owner@vger.kernel.org Mon May 28 00:31:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsRGZ-00043A-5Q
	for gcvg-git@gmane.org; Mon, 28 May 2007 00:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbXE0WbG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 18:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755291AbXE0WbG
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 18:31:06 -0400
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:4987 "EHLO
	smtp-vbr17.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbXE0WbF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 18:31:05 -0400
Received: from [192.168.1.100] (c911deb6.bhz.virtua.com.br [201.17.222.182])
	(authenticated bits=0)
	by smtp-vbr17.xs4all.nl (8.13.8/8.13.8) with ESMTP id l4RMUr13005116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 May 2007 00:31:00 +0200 (CEST)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <00ef01c7a0ad$78508e00$0200a8c0@AMD2500>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48589>

Aaron Gray escreveu:
>>>
>>> Theres a file called 'wish84.exe' under 'C:\Program
>>> Files\Git\usr\bin', but
>>> no wish.exe.
>>
>> can you edit this .bat to say wish84.exe iso. wish.exe ?
> 
> Getting message box saying :-
> 
>    child process exited abnormally
>        while executing
>    "close $refd"
>        (proceedure "readrefs" line 47)
>        invoked from within
>    "readrefs"
>        (file "C:\Program Files\Git\usr\bin\gitk line 6369)
> 
> :(

It seems that tcltk was executed; Unfortunately, it does work
flawlessly under wine, so there is little I can do.  I invite windows
experts to have a closer look.


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
