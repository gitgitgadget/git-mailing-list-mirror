From: Nicolas Pitre <nico@cam.org>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 15:40:04 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806101537440.23110@xanadu.home>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Denis Bueno <dbueno@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 21:41:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K69iH-0007AY-0V
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 21:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611AbYFJTkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 15:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754519AbYFJTkH
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 15:40:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8678 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984AbYFJTkG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 15:40:06 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K2900350IMSIP70@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 10 Jun 2008 15:40:05 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84537>

On Tue, 10 Jun 2008, Denis Bueno wrote:

> I started a thread a while back about repository corruption.  It
> manifested as a clone error and the thread is here:
> 
>     http://kerneltrap.org/mailarchive/git/2007/7/31/253475
> 
> I just ran, again, into corruption after my laptop kernel-panic'd.
> (Ironically, at the moment I ran into the corruption I was trying to
> push my repo to a backup location.)  Since that thread took place it
> seems a section about recovering from repo corruption was added to the
> manual --- but it assumes you can (or care to painstakingly) recreate
> each corrupted version.

Would you happen, by chance, to have another instance of that repository 
somewhere else with the concerned objects in it?


Nicolas
