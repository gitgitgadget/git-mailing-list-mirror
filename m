From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: git to libgit2 code relicensing
Date: Fri, 14 Nov 2008 22:33:52 +0100
Message-ID: <20081114213352.GA12134@auto.tuwien.ac.at>
References: <491DE6CC.6060201@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 14 22:35:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L16Jz-0001xJ-Le
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 22:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbYKNVdz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Nov 2008 16:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbYKNVdz
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 16:33:55 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:56251 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbYKNVdy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 16:33:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id EECB3680504A;
	Fri, 14 Nov 2008 22:33:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gsll3F+ml2Qd; Fri, 14 Nov 2008 22:33:52 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id CCC586804367; Fri, 14 Nov 2008 22:33:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <491DE6CC.6060201@op5.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101017>

On Fri, Nov 14, 2008 at 09:59:56PM +0100, Andreas Ericsson wrote:
> I've put everyone who "owns" more than 500 lines of code
> on the bcc list, figuring your permission is important
> but that you don't want the hundreds (well, one can hope)
> of emails from people saying "ok". The list of major owners
> was generated with "git showners *.c" in a worktree from
> the next branch of git.git.

I don't think, that your way for relicensing is bullet proof:

I consider many of my GIT patches as derived work from other parts of
GIT, even if git blame is stating me as author. I can gurantee you,
that I comply with the "Developer's Certificate of Origin 1.1" point
b, as its based on code out of git.git. But I can't tell you, from
which files I reused code anymore.

Probably other people did the same.

Your method is ignoring such derived code.

mfg Martin K=F6gler
