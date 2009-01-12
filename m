From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Google Summer of Code 2009
Date: Mon, 12 Jan 2009 14:01:18 +0100
Message-ID: <200901121401.19116.chriscool@tuxfamily.org>
References: <20090107183033.GB10790@spearce.org> <m3privyn20.fsf@localhost.localdomain> <alpine.DEB.1.00.0901102058220.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 12 14:02:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMMQe-0003ze-QV
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 14:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbZALNAk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jan 2009 08:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbZALNAk
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 08:00:40 -0500
Received: from smtp6-g21.free.fr ([212.27.42.6]:41745 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602AbZALNAj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 08:00:39 -0500
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 5FF2FE081AC;
	Mon, 12 Jan 2009 14:00:29 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 3D872E081E5;
	Mon, 12 Jan 2009 14:00:27 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901102058220.3586@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105338>

Hi,

Le samedi 10 janvier 2009, Johannes Schindelin a =E9crit :
> Hi,
>
> On Sat, 10 Jan 2009, Jakub Narebski wrote:
> > "Shawn O. Pearce" <spearce@spearce.org> writes:
> > > The application answers really need to be reworked; we need to
> > > address our 2008 results in these parts.
> >
> > By the way, do you know what happened with git-sequencer project?
>
> -- snip --
> commit 3bfd6761ce2f769746c6b84be97f7da0cad7cad1
> Author: Stephan Beyer <s-beyer@gmx.net>
> Date:   Wed Jan 7 19:07:31 2009 +0100
>
>     builtin-sequencer.c/prepare_commit_msg_hook: tiny simplification
>
>     Thanks to Christian.
> -- snap --

Yes, Stephan, Daniel and me are still working on it but very slowly.
You can see what happens on the repo here:

http://repo.or.cz/w/git/sbeyer.git?a=3Dshortlog;h=3Drefs/heads/seq-buil=
tin-dev

May be we should move our discussions, patches and everything on the gi=
t=20
mailing list as it may motivate us and people on the list to help.

One good thing too would be if Stephan could share is todo list.

By the way don't hesitate to put us in CC :-)

Regards,
Christian.
