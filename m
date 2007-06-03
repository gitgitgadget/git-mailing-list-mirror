From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 3 Jun 2007 19:10:40 +0200
Message-ID: <20070603171040.GE6992@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070603114843.GA14336@artemis> <878xb19ot5.fsf@graviton.dyn.troilus.org> <20070603133109.GD14336@artemis> <200706031548.30111.johan@herland.net> <20070603151921.GB30347@artemis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Poole <mdpoole@troilus.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 19:10:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HutbM-0005hY-QY
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 19:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbXFCRKl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 13:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753426AbXFCRKl
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 13:10:41 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:59620 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344AbXFCRKk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 13:10:40 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 73788817B;
	Sun,  3 Jun 2007 19:10:39 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 22E591F01B; Sun,  3 Jun 2007 19:10:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070603151921.GB30347@artemis>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49012>

On Sun, Jun 03, 2007 at 05:19:21PM +0200, Pierre Habouzit wrote:
>   Another think that notes do not address are another operation we
> usually do on bugs: merge (or duplicates). There is a think I hate in
> bugzilla and love in debbugs, it's that duplicate bugs are closed in the
> former, and merged in the latter. When two bugs are the same, their
> history are often *both* valuable, and you really don't want to lose one
> half, you want to merge them. And you also want the option to "unmerge"
> them, but for that the better option is to have the ability to duplicate
> a bug (aka debbugs cloning).

I can't wait for visualising the history of bugreports in gitk, along
with duplicates/forks and merges :)

>   Anyways it's just gossip, but maybe someone will have a brilliant
> ideas, so I'm just throwing my thoughts into this mail :)

/me wishes all gossip would be as productive as this one :)

Best regards,
-- 
Yann
