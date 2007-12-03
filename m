From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH] Make git status usage say git status instead of git commit
Date: Mon, 03 Dec 2007 11:15:04 +0100
Message-ID: <877ijww0d3.fsf@mid.deneb.enyo.de>
References: <1196658129-16708-1-git-send-email-shawn.bohrer@gmail.com>
	<7vir3gqr3d.fsf@gitster.siamese.dyndns.org>
	<854pf0hyy3.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 11:43:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz8la-0002Bk-Mg
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 11:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbXLCKmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 05:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbXLCKmv
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 05:42:51 -0500
Received: from mail.enyo.de ([212.9.189.167]:3822 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936AbXLCKmu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 05:42:50 -0500
X-Greylist: delayed 1664 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Dec 2007 05:42:50 EST
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1Iz8KP-0008CO-5o
	for git@vger.kernel.org; Mon, 03 Dec 2007 11:15:05 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.68)
	(envelope-from <fw@deneb.enyo.de>)
	id 1Iz8KO-0002xH-2N
	for git@vger.kernel.org; Mon, 03 Dec 2007 11:15:04 +0100
In-Reply-To: <854pf0hyy3.fsf@lola.goethe.zz> (David Kastrup's message of "Mon,
	03 Dec 2007 11:09:24 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66903>

* David Kastrup:

> Deprecating the dash form will probably mean that we need to think up
> (and document) a rationale for
>
>   man git-commit
>
> I actually have typed something like
>
>   man git commit
>
> a number of times already with obvious results.  Finger memory.

It's also a bit strange to have a git-commit(1) manpage when there is no
git-commit on the path.
