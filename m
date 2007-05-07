From: "Aaron Gray" <angray@beeb.net>
Subject: Re: Anyone running GIT on native Windows
Date: Mon, 7 May 2007 14:51:42 +0100
Message-ID: <002801c790ae$d86a1a90$0200a8c0@AMD2500>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500>	 <7vejlufmhd.fsf@assigned-by-dhcp.cox.net>	 <2b7f01c78fb1$be4dc6a0$0200a8c0@AMD2500>	 <463ECEF4.625F3633@eudaptics.com> <e5bfff550705070448t7813d064mbac82abb45591888@mail.gmail.com> <463F14FF.F8DF11EB@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Johannes Sixt" <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon May 07 15:58:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl3jm-00076i-73
	for gcvg-git@gmane.org; Mon, 07 May 2007 15:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933856AbXEGN6p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 09:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933865AbXEGN6p
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 09:58:45 -0400
Received: from lon1-mail-1.visp.demon.net ([193.195.70.4]:8257 "ehlo
	lon1-mail-1.visp.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933856AbXEGN6o (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2007 09:58:44 -0400
Received: from mwgray.force9.co.uk (EHLO AMD2500) ([212.159.110.144])
	by lon1-mail-1.visp.demon.net (MOS 3.7.5a-GA FastPath)
	with ESMTP id FFT85009 (AUTH angray);
	Mon, 07 May 2007 14:58:42 +0100 (BST)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.3028
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46464>

>> On 5/7/07, Johannes Sixt <J.Sixt@eudaptics.com> wrote:
>> > Aaron Gray wrote:
>> > > What I want is to be able to work in Windows CMD and envoke .sh 
>> > > scripts by
>> > > association (unfortunately you have to add the .sh on the command 
>> > > name
>> > > though).
>> >
>> > I run the mingw port exclusively from CMD without a .sh association. So
>> > exclusively that I don't even know whether any other way of using the
>> > tools even works. Of course, you have to get used to
>> >
>>
>> Is it public available?
>
> gitweb: http://repo.or.cz/w/git/mingw.git
> clone:  git://repo.or.cz/git/mingw.git
>
> I only have either time to hack on mingw.git or a Windows installation,
> but not both at the same time. Therefore, the port is now a bit falling
> back (it's still at 1.5.1). I hope to be able to change this in a few
> weeks.

Great I will check this out when I get some time.

An .sh to c converter would be the best solution. I will be looking into how 
hard this would be to do.

> The next big thing to think about is an installer. Does anyone have a
> suggestion for a free installer tool? I only know about Microsoft's WiX
> (wix.sf.net), but it requires .NET (for the developer, not the user).

I suggest Nullsoft :-

        http://nsis.sourceforge.net/Main_Page

This is used by several open source projects.

Aaron
