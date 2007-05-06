From: "Aaron Gray" <angray@beeb.net>
Subject: Re: Anyone running GIT on native Windows
Date: Sun, 6 May 2007 08:39:54 +0100
Message-ID: <2b7f01c78fb1$be4dc6a0$0200a8c0@AMD2500>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500> <7vejlufmhd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 06 09:47:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkbSQ-0002P7-DR
	for gcvg-git@gmane.org; Sun, 06 May 2007 09:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338AbXEFHq7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 03:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755339AbXEFHq7
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 03:46:59 -0400
Received: from lon1-mail-1.visp.demon.net ([193.195.70.4]:3015 "ehlo
	lon1-mail-1.visp.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755338AbXEFHq6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 03:46:58 -0400
Received: from mwgray.force9.co.uk (EHLO AMD2500) ([212.159.110.144])
	by lon1-mail-1.visp.demon.net (MOS 3.7.5a-GA FastPath)
	with ESMTP id FFT20408 (AUTH angray);
	Sun, 06 May 2007 08:46:57 +0100 (BST)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.3028
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46311>

> "Aaron Gray" <angray@beeb.net> writes:
>
>> I want to use GIT on Windows without Cygwin or MinGW.
>>
>> Has anyone tried this with GNU sh and utils compiled under Windows ?
>
> Call me Windoze uninitiated, but isn't that pretty much what
> MinGW is about?

MinGW still runs in its own directory tree and uses Unix paths.

What I want is to be able to work in Windows CMD and envoke .sh scripts by 
association (unfortunately you have to add the .sh on the command name 
though).

Ideally the .sh scripts would be converted or rewritten in C, this would be 
the best solution.

Anyway best to get someone else take on the problem.

Aaron
