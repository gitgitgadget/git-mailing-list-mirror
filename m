From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: cvsimport: rewritten in Perl
Date: Sun, 3 Jul 2005 14:21:10 +0200
Message-ID: <20050703122110.GC18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de> <20050630161423.GC26808@pc117b.liacs.nl> <20050630163000.GT10850@kiste.smurf.noris.de> <Pine.LNX.4.63.0506301321350.1667@localhost.localdomain> <pan.2005.07.01.09.43.24.106822@smurf.noris.de> <20050703103517.GJ5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jul 03 14:38:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dp3jM-00024A-K4
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 14:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVGCMhj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 08:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVGCMhj
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 08:37:39 -0400
Received: from nibbel.kulnet.kuleuven.ac.be ([134.58.240.41]:36025 "EHLO
	nibbel.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261403AbVGCMhc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2005 08:37:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by nibbel.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 685784BEE8
	for <git@vger.kernel.org>; Sun,  3 Jul 2005 14:37:31 +0200 (CEST)
Received: from antonius.kulnet.kuleuven.ac.be (antonius.kulnet.kuleuven.ac.be [134.58.240.73])
	by nibbel.kulnet.kuleuven.ac.be (Postfix) with ESMTP id DF6E94BF08
	for <git@vger.kernel.org>; Sun,  3 Jul 2005 14:37:28 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by antonius.kulnet.kuleuven.ac.be (Postfix) with ESMTP id B616F4C33B
	for <git@vger.kernel.org>; Sun,  3 Jul 2005 14:37:28 +0200 (CEST)
Received: (qmail 25557 invoked by uid 500); 3 Jul 2005 12:21:10 -0000
To: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050703103517.GJ5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 03, 2005 at 12:35:17PM +0200, Sven Verdoolaege wrote:
> On Fri, Jul 01, 2005 at 11:43:34AM +0200, Matthias Urlichs wrote:
> > Personally, I'd prefer merging.
> > 
> Pull this one then:
> 
> http://www.liacs.nl/~sverdool/git.git#cvs2git

That was a cogito branch, btw.
In git you'd say:

git-http-pull -c -v -t -a heads/cvs2git http://www.liacs.nl/~sverdool/git.git/

skimo
