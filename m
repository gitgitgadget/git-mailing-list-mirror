From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Autoconf/Automake
Date: Fri, 16 Jun 2006 00:58:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606160053560.7480@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1150324030.23268.12.camel@dv> <20060615072450.GF7766@nowhere.earth>
 <20060615133146.GA5794@steel.home> <20060615201000.600939E2BC@derisoft.derived-software.demon.co.uk>
 <Pine.LNX.4.63.0606152239270.7480@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060615220534.GL7766@nowhere.earth>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Phil Richards <news@derived-software.ltd.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 00:58:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fr0nM-0003ba-1F
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 00:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWFOW6d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 18:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWFOW6c
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 18:58:32 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:26023 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750734AbWFOW6c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jun 2006 18:58:32 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 11F0321AF;
	Fri, 16 Jun 2006 00:58:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 01ABB21E5;
	Fri, 16 Jun 2006 00:58:31 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id C27C221AF;
	Fri, 16 Jun 2006 00:58:30 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060615220534.GL7766@nowhere.earth>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21920>

Hi,

On Fri, 16 Jun 2006, Yann Dirson wrote:

> On Thu, Jun 15, 2006 at 10:42:40PM +0200, Johannes Schindelin wrote:
> > As for now, I fail to see why the current system is not adequate for git!
> 
> I can reassure you, gazillions of people still fail to see why cvs is
> not adequate for their project.  And the ratio of devs in the
> corporate world not knowning git to those not knowning cvs is far
> superior to 2.  And everyone here knows cvs is not more adequate than
> git for so many tasks :)

You know as well as I that this comparison is unfair. I am _NOT_ a 
corporate person. I hope that you do not judge me as a complete airhead.

The point is: the right tool solves the problem. You can have a tool which 
is mighty cool, but way too powerful (AKA complicated).

As for CVS: there _are_ a few use cases where CVS is just the right tool. 
There are many more use cases where git is more than adequate, where CVS 
is not.

_BUT_: there are cases where something like autoconf/jam/cmake/blablabla 
is adequate, but I still fail to see why for git, the makefile system 
should not work. It is the most transparent way to configure a make system 
I encountered. It is short, concise, and does the job. And I understand 
it. As opposed to autoconf/jam/cmake/blablabla.

Hth,
Dscho
