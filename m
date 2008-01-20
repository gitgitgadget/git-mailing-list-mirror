From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Time to flush developer accumulated patches?
Date: Sun, 20 Jan 2008 11:47:29 +0100
Message-ID: <DD3B1282-B9A7-4A29-8F21-5D9C1A8048E1@zib.de>
References: <e5bfff550801200210y212d0921x214773596810be52@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 11:50:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGXkr-0002YW-Oq
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 11:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbYATKtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 05:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbYATKtw
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 05:49:52 -0500
Received: from mailer.zib.de ([130.73.108.11]:63258 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391AbYATKtv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 05:49:51 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0KAkQO1018947;
	Sun, 20 Jan 2008 11:49:42 +0100 (CET)
Received: from [192.168.178.21] (brln-4db91f4c.pool.einsundeins.de [77.185.31.76])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0KAkPb7013304
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 20 Jan 2008 11:46:25 +0100 (MET)
In-Reply-To: <e5bfff550801200210y212d0921x214773596810be52@mail.gmail.com>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71172>


On Jan 20, 2008, at 11:10 AM, Marco Costalba wrote:

> Reading mailing list threads it is becoming common these days to hear
> about contributors with patches ready to be sent as soon as 1.5.4 is
> out.
>
> Would be a good idea to open a new branch new_stuff as a target for
> this pending stuff?

I don't think this is a good idea ...


> I understand that you want people focused on fixing bugs, but I also
> understand that people don't ;-)
>
> Opening a new_stuff branch could have the following benefits:
>
> - Give more time to fix bugs before 1.5.4 is out without stopping
> people from having fun and reduce the pressure to release.

... because I believe it is a good thing to keep the pressure
to release.  The 1.5.4 cycle already became quite long.


> - Reduce the merging impact when master reopens because patches are
> already merged in new_stuff and developers have already taken care of
> conflicts
>
> - Do not slow down the wheel: I can develop some patches and keep them
> myself, but until are not discussed in the list and eventually got in
> master has little meaning to continue develop additional stuff.

Isn't this the idea: slow down a bit, focus on fixing bugs instead
of developing new stuff, and release 1.5.4.


> - Perhaps it's lack of reviewing time on your side that worries you
> (as is normal because we are on bug fixes mode in master) but upgrade
> from new_stuff to master would be not automatic nor guaranteed but at
> least people have an idea at what's going on and can keep contributing
> in code and ideas.

Isn't this the purpose of pu?

	Steffen
