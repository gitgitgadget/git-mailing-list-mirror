From: "Aaron Gray" <angray@beeb.net>
Subject: Re:  GIT on MinGW, with tcltk for gitk
Date: Sun, 27 May 2007 21:39:32 +0100
Message-ID: <00a601c7a09f$218c1020$0200a8c0@AMD2500>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org> <4659D306.6030803@xs4all.nl> <f3cnm6$gda$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: <hanwen@xs4all.nl>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 27 22:40:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsPWz-0004aF-8Q
	for gcvg-git@gmane.org; Sun, 27 May 2007 22:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbXE0Ujz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 16:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbXE0Ujy
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 16:39:54 -0400
Received: from lon1-mail-1.visp.demon.net ([193.195.70.4]:6181 "ehlo
	lon1-mail-1.visp.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752806AbXE0Ujy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 May 2007 16:39:54 -0400
Received: from mwgray.force9.co.uk (EHLO AMD2500) ([212.159.110.144])
	by lon1-mail-1.visp.demon.net (MOS 3.7.5a-GA FastPath)
	with ESMTP id FGK88919 (AUTH angray);
	Sun, 27 May 2007 21:39:53 +0100 (BST)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.3028
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48577>

> Han-Wen Nienhuys escreveu:
>> There is a 1.5.2-3 installer which includes a cross-compiled tcltk. 
>> 
>>   http://lilypond.org/git/binaries/mingw/
>> 
>> What is the proper way to have the 'gitk' command start up with wish
>> automatically?
> 
> I've just uploaded 1.5.2-5, which also writes a gitk.bat file, containing
> proper paths. However, I can't get it working in Wine. Any windows user
> that cares to test? 
> 
>  http://lilypond.org/git/binaries/mingw/git-1.5.2-5.mingw.exe
> 

git clone or git-clone are not accessable still.

C:\Work\test>git init
warning: templates not found C:/Program Files/Git/usr/bin@template_dir@
Initialized empty Git repository in .git/

Aaron
