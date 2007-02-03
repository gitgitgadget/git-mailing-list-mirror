From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] config.txt: update branch.<name>.merge documentation
Date: Sat, 3 Feb 2007 17:29:50 +0100
Message-ID: <20070203162949.GF4266@nan92-1-81-57-214-146.fbx.proxad.net>
References: <87irejgsyj.fsf@gmail.com> <20070203155652.GL5362@nan92-1-81-57-214-146.fbx.proxad.net> <8aa486160702030819k24a42ac4w115b83980d3ee17e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 17:30:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDNmq-0003WB-Uq
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 17:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946492AbXBCQaq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 3 Feb 2007 11:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946493AbXBCQaq
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 11:30:46 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:60057 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946492AbXBCQap (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 11:30:45 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 55CE07D24;
	Sat,  3 Feb 2007 17:30:44 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 0A4F71F084; Sat,  3 Feb 2007 17:29:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <8aa486160702030819k24a42ac4w115b83980d3ee17e@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38573>

On Sat, Feb 03, 2007 at 05:19:53PM +0100, Santi B=E9jar wrote:
> >git-parser-remote also looks branch.*.merge with --get-all, so it is
> >interesting to know what happens for multiple values (if git-fetch
> >just marks them all, how does git-pull react ?).
>=20
> The last sentence in the branch.<name>.merge says that it would
> produce an octopus, is this enough?

D'oh, right.
