From: cmn@elego.de (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto)
Subject: Re: Inconsistency in messages about --set-upstream from git pull and git branch
Date: Sun, 02 Dec 2012 02:29:31 +0100
Message-ID: <87y5hhjl6s.fsf@centaur.cmartin.tk>
References: <CAN2DD_Hc4ZoQZefUirSZF=PZY5654yqrQfk5g1VzBLixEC=T-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: danr@student.chalmers.se
X-From: git-owner@vger.kernel.org Sun Dec 02 02:36:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeyTy-0006Tj-W8
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 02:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496Ab2LBBgT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Dec 2012 20:36:19 -0500
Received: from hessy.cmartin.tk ([78.47.67.53]:51743 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751113Ab2LBBgS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Dec 2012 20:36:18 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Dec 2012 20:36:18 EST
Received: from cmartin.tk (p4FC5C868.dip.t-dialin.net [79.197.200.104])
	by hessy.dwim.me (Postfix) with ESMTPA id C1A5781546;
	Sun,  2 Dec 2012 02:29:26 +0100 (CET)
Received: (nullmailer pid 13369 invoked by uid 1000);
	Sun, 02 Dec 2012 01:29:31 -0000
In-Reply-To: <CAN2DD_Hc4ZoQZefUirSZF=PZY5654yqrQfk5g1VzBLixEC=T-g@mail.gmail.com>
	("Dan =?utf-8?Q?Ros=C3=A9n=22's?= message of "Sat, 1 Dec 2012 16:36:06
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210986>

Dan Ros=C3=A9n <danr@student.chalmers.se> writes:

>
>     git branch --set-upstream master origin/<branch>
>

This has been fixed already in 1.8.0.1

   cmn
