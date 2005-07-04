From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] cvsimport: rewritten in Perl
Date: Mon, 4 Jul 2005 15:03:24 +0200
Message-ID: <20050704130324.GK18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de> <20050630193825.GA17345@pc117b.liacs.nl> <20050630210023.GY10850@kiste.smurf.noris.de>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 04 15:21:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpQsJ-0001DX-BH
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 15:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVGDNUU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 09:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVGDNUT
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 09:20:19 -0400
Received: from spoetnik.kulnet.kuleuven.ac.be ([134.58.240.46]:7654 "EHLO
	spoetnik.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261715AbVGDNUK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 09:20:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id D1C4B33E8E
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 15:20:09 +0200 (CEST)
Received: from antonius.kulnet.kuleuven.ac.be (antonius.kulnet.kuleuven.ac.be [134.58.240.73])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 14C8C33E7F
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 15:20:08 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by antonius.kulnet.kuleuven.ac.be (Postfix) with ESMTP id EE8AF4C2C5
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 15:20:07 +0200 (CEST)
Received: (qmail 13223 invoked by uid 500); 4 Jul 2005 13:03:24 -0000
To: Matthias Urlichs <smurf@smurf.noris.de>
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050630210023.GY10850@kiste.smurf.noris.de>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2005 at 11:00:23PM +0200, Matthias Urlichs wrote:
> Sven Verdoolaege:
> > It would also be nice if the user could pass extra options
> > to cvsps (notably '-z').
> > 
> Ditto.  ;-)

Why not an explicit '-z' option as in the current git-cvsimport-script ?

skimo
