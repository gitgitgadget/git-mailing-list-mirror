From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Fri, 30 Sep 2005 14:22:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509301421160.15604@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
 <Pine.LNX.4.60.0509292106080.17860@hermes-1.csi.cam.ac.uk>
 <20050929201127.GB31516@redhat.com> <Pine.LNX.4.64.0509291413060.5362@g5.osdl.org>
 <Pine.LNX.4.64.0509291425560.5362@g5.osdl.org> <20050929213312.GD31516@redhat.com>
 <Pine.LNX.4.64.0509291451540.5362@g5.osdl.org>
 <Pine.LNX.4.60.0509292309470.17860@hermes-1.csi.cam.ac.uk>
 <7vek77ea2s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 14:23:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELJuN-00053x-TT
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 14:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbVI3MW2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 08:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbVI3MW1
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 08:22:27 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:62862 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030284AbVI3MW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 08:22:27 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 286B013E6DF; Fri, 30 Sep 2005 14:22:26 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0E1029DB61; Fri, 30 Sep 2005 14:22:26 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id EC1BE91280; Fri, 30 Sep 2005 14:22:25 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D352B13E6DF; Fri, 30 Sep 2005 14:22:25 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek77ea2s.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9557>

Hi,

On Thu, 29 Sep 2005, Junio C Hamano wrote:

> Anton Altaparmakov <aia21@cam.ac.uk> writes:
> 
> > On Thu, 29 Sep 2005, Linus Torvalds wrote:
> >> On Thu, 29 Sep 2005, Dave Jones wrote:
> >> > What I find amusing is that it was a patch rejection mail from you
> >> > *years* back (circa 2000 iirc), telling me my pine corrupted whitespace,
> >> > that made me switch MUA ;-)
> >> > 
> >> > All these years later, and it's still buggered ?
> >> 
> >> Actually, it seems better. It seems to be buggered by default, but it used 
> >> to be that you had to actually recompile pine to make it behave. Now you 
> >> can just disable "strip-whitespace-before-send" and _enable_ 
> >> "quell-flowed-text" and those together seem to do the trick. No extra 
> >> patches or recompiles necessary.
> >
> > Indeed.  I use those two options like that, too.  (-:
> 
> Anybody interested in adding entry to SubmittingPatches MUA
> Specific Help section?

Did I miss something? Straight from my local git directory:

-- snip --

Pine
----

(Johannes Schindelin)

I don't know how many people still use pine, but for those poor
souls it may be good to mention that the quell-flowed-text is
needed for recent versions.

... the "no-strip-whitespace-before-send" option, too. AFAIK it
was introduced in 4.60.

-- snap --

Hth,
Dscho
