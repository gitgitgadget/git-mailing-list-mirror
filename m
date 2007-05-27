From: "Aaron Gray" <angray@beeb.net>
Subject: Re: GIT on MinGW, with tcltk for gitk
Date: Sun, 27 May 2007 23:22:08 +0100
Message-ID: <00ef01c7a0ad$78508e00$0200a8c0@AMD2500>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org> <4659D306.6030803@xs4all.nl> <f3cnm6$gda$1@sea.gmane.org> <00a601c7a09f$218c1020$0200a8c0@AMD2500> <4659F5D0.2070406@xs4all.nl> <00b901c7a0a5$77983420$0200a8c0@AMD2500> <00c401c7a0a7$8a5690a0$0200a8c0@AMD2500> <f329bf540705271455m4c0f5a55v14b9a8cc6bd7778d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon May 28 00:22:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsR8L-0002tO-Ft
	for gcvg-git@gmane.org; Mon, 28 May 2007 00:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbXE0WWe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 18:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbXE0WWe
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 18:22:34 -0400
Received: from lon1-mail-1.visp.demon.net ([193.195.70.4]:29679 "ehlo
	lon1-mail-1.visp.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751492AbXE0WWd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 May 2007 18:22:33 -0400
Received: from mwgray.force9.co.uk (EHLO AMD2500) ([212.159.110.144])
	by lon1-mail-1.visp.demon.net (MOS 3.7.5a-GA FastPath)
	with ESMTP id FGK92017 (AUTH angray);
	Sun, 27 May 2007 23:22:32 +0100 (BST)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.3028
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48587>

> 2007/5/27, Aaron Gray <angray@beeb.net>:
>
>> '"C:\Program Files\Git\usr\bin\wish.exe"' is not recognized as an 
>> internal
>> or external command, operable program or batch file.
>>
>> Theres a file called 'wish84.exe' under 'C:\Program Files\Git\usr\bin', 
>> but
>> no wish.exe.
>
> can you edit this .bat to say wish84.exe iso. wish.exe ?

Getting message box saying :-

    child process exited abnormally
        while executing
    "close $refd"
        (proceedure "readrefs" line 47)
        invoked from within
    "readrefs"
        (file "C:\Program Files\Git\usr\bin\gitk line 6369)

:(

Aaron
