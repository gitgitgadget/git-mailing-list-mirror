From: "Aaron Gray" <angray@beeb.net>
Subject: Re: GIT on MinGW, with tcltk for gitk
Date: Sun, 27 May 2007 22:39:39 +0100
Message-ID: <00c401c7a0a7$8a5690a0$0200a8c0@AMD2500>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org> <4659D306.6030803@xs4all.nl> <f3cnm6$gda$1@sea.gmane.org> <00a601c7a09f$218c1020$0200a8c0@AMD2500> <4659F5D0.2070406@xs4all.nl> <00b901c7a0a5$77983420$0200a8c0@AMD2500>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Han-Wen Nienhuys" <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Sun May 27 23:40:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsQTM-0005NI-5g
	for gcvg-git@gmane.org; Sun, 27 May 2007 23:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756686AbXE0VkM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 17:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754281AbXE0VkM
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 17:40:12 -0400
Received: from lon1-mail-1.visp.demon.net ([193.195.70.4]:20358 "ehlo
	lon1-mail-1.visp.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759193AbXE0VkG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 May 2007 17:40:06 -0400
Received: from mwgray.force9.co.uk (EHLO AMD2500) ([212.159.110.144])
	by lon1-mail-1.visp.demon.net (MOS 3.7.5a-GA FastPath)
	with ESMTP id FGK90607 (AUTH angray);
	Sun, 27 May 2007 22:40:05 +0100 (BST)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.3028
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48584>

>> Aaron Gray escreveu:
>>
>>> C:\Work\test>git init
>>> warning: templates not found C:/Program Files/Git/usr/bin@template_dir@
>>> Initialized empty Git repository in .git/
>>>
>>> Aaron
>>
>> Thanks for the report. Can you try again with 1.5.2-7  ? It should be 
>> available
>> in a few minutes.
>
> Okay, I'm up for all the testing thats needed. Just dont know the 
> territory that well though, as I am a Windozer :)

git init appears to work fine now, the template path is found.

git clone or git-clone is still not working.

'git clone' just gives a list of git's commands.

git-clone gives usual :-

C:\Work\test2>git-clone git://git.kernel.org/pub/scm/git/git.git
'git-clone' is not recognized as an internal or external command,
operable program or batch file.

>> Also, can you tell me if gitk.bat works for you?
>
> Okay, I just type 'gitk' ?

C:\Work>gitk
'"C:\Program Files\Git\usr\bin\wish.exe"' is not recognized as an internal 
or external command, operable program or batch file.

Theres a file called 'wish84.exe' under 'C:\Program Files\Git\usr\bin', but 
no wish.exe.

Aaron

Aaron
