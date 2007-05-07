From: "Aaron Gray" <angray@beeb.net>
Subject: Re: Anyone running GIT on native Windows
Date: Mon, 7 May 2007 17:39:42 +0100
Message-ID: <00c701c790c6$512804d0$0200a8c0@AMD2500>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500>  <7vejlufmhd.fsf@assigned-by-dhcp.cox.net>  <2b7f01c78fb1$be4dc6a0$0200a8c0@AMD2500>  <463ECEF4.625F3633@eudaptics.com> <e5bfff550705070448t7813d064mbac82abb45591888@mail.gmail.com> <463F14FF.F8DF11EB@eudaptics.com> <002801c790ae$d86a1a90$0200a8c0@AMD2500> <Pine.LNX.4.64.0705071624210.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <J.Sixt@eudaptics.com>, <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 07 18:47:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl6MX-00068p-DD
	for gcvg-git@gmane.org; Mon, 07 May 2007 18:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965927AbXEGQqq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 12:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934430AbXEGQqq
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 12:46:46 -0400
Received: from lon1-mail-1.visp.demon.net ([193.195.70.4]:5735 "ehlo
	lon1-mail-1.visp.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934429AbXEGQqp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2007 12:46:45 -0400
Received: from mwgray.force9.co.uk (EHLO AMD2500) ([212.159.110.144])
	by lon1-mail-1.visp.demon.net (MOS 3.7.5a-GA FastPath)
	with ESMTP id FFT94181 (AUTH angray);
	Mon, 07 May 2007 17:46:43 +0100 (BST)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.3028
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46471>

Hi,

>> An .sh to c converter would be the best solution. I will be looking into
>> how hard this would be to do.
>
> NACK.
>
> A stupid .sh to c converter will almost certainly result in slow and
> hard-to-debug code.

I had presumed you do not have to really look at the code if the tanslator 
is sound.

> If you had bothered to check, you'd know that there are ongoing efforts to
> do the ports properly.

This is good. So the shell code is being migrated to C ?

Could you give me a link or refernce please ?

Aaron
