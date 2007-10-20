From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [msysGit] Re: Fourth incarnation of the msysGit herald
Date: Sat, 20 Oct 2007 20:04:20 +0200
Message-ID: <A24982F6-40B2-4897-904E-99A135EC9D41@zib.de>
References: <Pine.LNX.4.64.0710200024460.25221@racer.site> <20071020133359.GB19521@efreet.light.src>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sat Oct 20 20:08:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjIjx-0005RR-Hi
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 20:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbXJTSHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 14:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753846AbXJTSHq
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 14:07:46 -0400
Received: from mailer.zib.de ([130.73.108.11]:38118 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753961AbXJTSHp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 14:07:45 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9KI2qXL009934;
	Sat, 20 Oct 2007 20:04:43 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1a6f2.pool.einsundeins.de [77.177.166.242])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9KI2pNb009031
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 20 Oct 2007 20:02:51 +0200 (MEST)
In-Reply-To: <20071020133359.GB19521@efreet.light.src>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61845>


On Oct 20, 2007, at 3:33 PM, Jan Hudec wrote:

> On Sat, Oct 20, 2007 at 00:25:49 +0100, Johannes Schindelin wrote:
>> git gui
>> =======
>>
>> git gui is a really nice program, and as I often said, I consider it
>> more porcelain than a gui, since it uses the git core directly,  
>> instead
>> of wrapping around porcelain commands.
>>
>> The user experience I had with git gui made me think that this should
>> be the primary interface Windows users should be confronted with, not
>> the command line.
>>
>> The major problem we had in msysGit is that git-gui was to be  
>> launched
>> from the Start Menu, or a QuickLaunch icon.  This is in contrast to
>> the shell, where you usually start git gui in a working directory.
>
> It would be nice to install an entry in the explorer menu to run  
> git-gui in
> a selected directory. It can be done by just writing something like  
> to the
> registry (completely untested -- I just looked it up on the internet):

What you propose is already there!

Did you try the most recent setup?

http://msysgit.googlecode.com/files/Git-1.5.3-preview20071019.exe

	Steffen
