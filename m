From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] l10n: de.po: translate 35 new messages
Date: Mon, 18 Feb 2013 21:15:56 +0100
Message-ID: <87y5elv0n7.fsf@pctrast.inf.ethz.ch>
References: <1361211754-5641-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <jk@jk.gs>, <stimming@tuhh.de>, <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:16:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7X8W-0001A1-23
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 21:16:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757346Ab3BRUQC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 15:16:02 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:26937 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757317Ab3BRUQA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 15:16:00 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 18 Feb
 2013 21:15:54 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (46.126.8.85) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 18 Feb
 2013 21:15:57 +0100
In-Reply-To: <1361211754-5641-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Mon, 18 Feb 2013 19:22:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216513>

Ralf Thielow <ralf.thielow@gmail.com> writes:

>  #: builtin/branch.c:888
>  msgid "too many branches for a rename operation"
> -msgstr ""
> +msgstr "zu viele Zweige angegeben"

You lost the "rename" bit, was that on purpose?

Other than that, ACK.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
