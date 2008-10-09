From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: ls-files [Was: Re: Fwd: git status options feature suggestion]
Date: Thu, 9 Oct 2008 14:41:18 -0700
Message-ID: <20081009214118.GZ8203@spearce.org>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com> <20081009061136.GA24288@coredump.intra.peff.net> <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com> <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com> <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de> <m3ej2p4g3r.fsf_-_@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Caleb Cushing <xenoterracide@gmail.com>
To: James Cloos <cloos@jhcloos.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 23:42:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko3H9-0003rI-Pg
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 23:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620AbYJIVlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 17:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755501AbYJIVlU
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 17:41:20 -0400
Received: from george.spearce.org ([209.20.77.23]:38358 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275AbYJIVlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 17:41:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BDEB53835F; Thu,  9 Oct 2008 21:41:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <m3ej2p4g3r.fsf_-_@lugabout.jhcloos.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97891>

James Cloos <cloos@jhcloos.com> wrote:
> >>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > How about "git ls-files -o"?
> >> 
> >> doh... hadn't even heard of that command.
> 
> Johannes> Which is good!  As ls-files is listed as plumbing.
> Johannes> Users should not need to call ls-files,
> 
> That is a bug, then.  ls-files is one of the more important user-level
> commands in git.
> 
> It is vastly more efficient than find(1) or a --recursive call to
> grep(1).

How about using "git grep" then?  No need for ls-files...

-- 
Shawn.
