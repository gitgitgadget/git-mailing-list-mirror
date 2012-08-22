From: cmn@elego.de (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto)
Subject: Re: Git to use XDG Base Directory Standard
Date: Wed, 22 Aug 2012 23:44:39 +0200
Message-ID: <871uiy8uuw.fsf@centaur.cmartin.tk>
References: <50355044.7040201@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lanoxx <lanoxx@gmx.net>
X-From: git-owner@vger.kernel.org Wed Aug 22 23:44:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4IjE-0000MW-QK
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 23:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335Ab2HVVoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 17:44:39 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:50037 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756619Ab2HVVoh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 17:44:37 -0400
Received: from cmartin.tk (p57A1F6BF.dip.t-dialin.net [87.161.246.191])
	by hessy.dwim.me (Postfix) with ESMTPA id D286E8169C;
	Wed, 22 Aug 2012 23:44:35 +0200 (CEST)
Received: (nullmailer pid 7464 invoked by uid 1000);
	Wed, 22 Aug 2012 21:44:39 -0000
In-Reply-To: <50355044.7040201@gmx.net> (lanoxx@gmx.net's message of "Wed, 22
	Aug 2012 23:33:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204102>

Lanoxx <lanoxx@gmx.net> writes:

> Hi,
>
> Git and Gitk are currently using the ~/.gitconfig and ~/.gitk files in
> the $HOME directory. It would be nice to use the XDG Base Directory
> standard for the location instead, see [1] and [2]. Are there any
> plans regarding this standard?

Git does this starting at 1.7.12. See the release notes, e.g. at
https://github.com/git/git/blob/master/Documentation/RelNotes/1.7.12.txt#L18-23

   cmn
