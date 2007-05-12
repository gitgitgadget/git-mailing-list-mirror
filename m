From: "Aaron Gray" <angray@beeb.net>
Subject: Re: Anyone running GIT on native Windows
Date: Sat, 12 May 2007 03:23:04 +0100
Message-ID: <1de101c7943c$794804a0$0200a8c0@AMD2500>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500>		 <7vejlufmhd.fsf@assigned-by-dhcp.cox.net>		 <2b7f01c78fb1$be4dc6a0$0200a8c0@AMD2500>		 <463ECEF4.625F3633@eudaptics.com> <e5bfff550705070448t7813d064mbac82abb45591888@mail.gmail.com> <463F14FF.F8DF11EB@eudaptics.com> <46415106.5040401@xs4all.nl> <46417351.6BBA9313@eudaptics.com> <4643EA77.4040803@xs4all.nl> <46449B0D.5FCD66F1@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Johannes Sixt" <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Sat May 12 04:23:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmhGQ-00085i-JU
	for gcvg-git@gmane.org; Sat, 12 May 2007 04:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877AbXELCXL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 22:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755048AbXELCXL
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 22:23:11 -0400
Received: from lon1-mail-1.visp.demon.net ([193.195.70.4]:7887 "ehlo
	lon1-mail-1.visp.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754877AbXELCXK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 May 2007 22:23:10 -0400
Received: from mwgray.force9.co.uk (EHLO AMD2500) ([212.159.110.144])
	by lon1-mail-1.visp.demon.net (MOS 3.7.5a-GA FastPath)
	with ESMTP id FFY78885 (AUTH angray);
	Sat, 12 May 2007 03:23:08 +0100 (BST)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.3028
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47013>

> Han-Wen Nienhuys wrote:
>> http://lilypond.org/git/binaries/mingw/git-1.5.1-1.mingw.exe
>
> This resulted in a mostly working git toolset after I've done this in
> addition to installing it:
>
> - Installed MSYS (of course ;)
> - Install libiconv-2.dll, which can be found in
> diffutils-2.8.7-1-dep.zip from
> http://sourceforge.net/project/showfiles.php?group_id=2435 (available in
> Section Snapshot->MSYS) (rename libiconv2.dll to libiconv-2.dll)
> - Set the path to MSYS and Git manually.

This direct link is better. The above link does not take you to the correct 
place.

http://sourceforge.net/project/downloading.php?group_id=23617&use_mirror=kent&filename=diffutils-2.8.7-1-dep.zip&19135304

> For extra bonus points, I should also have installed
> bash-3.1-MSYS-1.0.11-snapshot.tar.bz2 (without which 'git am' fails) and
> msysDTK-1.0.1.exe for ssh and perl, but I haven't.
>
> gitk and git-gui are untested; they need tcltk-8.4.1-1.exe, of course.

Got GIT :)

Cheers,

Aaron
