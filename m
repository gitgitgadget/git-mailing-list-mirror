From: Kalle Olavi Niemitalo <kon@iki.fi>
Subject: Re: Trouble with gitk and ActiveState tcltk on OS X
Date: Mon, 11 Feb 2008 10:26:26 +0200
Message-ID: <87myq7c30t.fsf@Astalo.kon.iki.fi>
References: <m2ve4wh5sx.fsf@ziti.evri.corp>
	<20080211044941.GX24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 09:47:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOUK1-0004za-4P
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 09:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbYBKIqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 03:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbYBKIqy
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 03:46:54 -0500
Received: from 82-128-242-48-Rajakyla-TR1.suomi.net ([82.128.242.48]:37235
	"EHLO Astalo.kon.iki.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750826AbYBKIqy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 03:46:54 -0500
Received: from Kalle by Astalo.kon.iki.fi with local (Exim 4.52)
	id 1JOTze-0000lf-Ax
	for git@vger.kernel.org; Mon, 11 Feb 2008 10:26:26 +0200
In-Reply-To: <20080211044941.GX24004@spearce.org> (Shawn O. Pearce's message
	of "Sun, 10 Feb 2008 23:49:41 -0500")
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.0.51 (gnu/linux)
X-Accept-Language: fi;q=1.0, en;q=0.9, sv;q=0.5, de;q=0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73486>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> In short, why not just use the native Aqua Tcl/Tk that Apple ships?

With the Tcl 8.4b and Tk 8.4 that Apple bundles with Mac OS 10.5.1,
two-finger scrolling with the MacBook touchpad does not work in gitk,
and I think buttons in dialog boxes were sometimes invisible.
Upgrading both to 8.4.16 (Tk still Aqua) fixed these problems for me.
