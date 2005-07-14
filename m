From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-diff-*: Allow "--name-only -z" as alias for "--name-only-z"
Date: Thu, 14 Jul 2005 15:17:15 -0700
Message-ID: <7vvf3d6nis.fsf@assigned-by-dhcp.cox.net>
References: <20050714215126.GY9915@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Jul 15 00:21:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtC4R-00036a-5M
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 00:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbVGNWUC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 18:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbVGNWSR
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 18:18:17 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:32456 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261412AbVGNWRR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 18:17:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050714221712.YZMZ15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 14 Jul 2005 18:17:12 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20050714215126.GY9915@kiste.smurf.noris.de> (Matthias Urlichs's message of "Thu, 14 Jul 2005 23:51:26 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I've considered it, but what happens if you give -z first and
then name-only?
