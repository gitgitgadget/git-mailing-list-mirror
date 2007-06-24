From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fastimport pull request
Date: Sun, 24 Jun 2007 15:22:50 -0700
Message-ID: <7vr6o1ouv9.fsf@assigned-by-dhcp.cox.net>
References: <20070622232458.GK17393@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 00:23:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2aTu-0003Wd-S2
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 00:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbXFXWWx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 24 Jun 2007 18:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbXFXWWx
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 18:22:53 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:38445 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbXFXWWw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jun 2007 18:22:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070624222252.NKDM3339.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 Jun 2007 18:22:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FaNr1X0091kojtg0000000; Sun, 24 Jun 2007 18:22:51 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50831>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> The following changes since commit 45fd8bd32dd68ce6b14a406d0abbd6f564=
90131c:
>   Ismail D=C3=B6nmez (1):
>         Change default man page path to /usr/share/man
>
> are available in the git repository at:
>
>   repo.or.cz:/srv/git/git/fastimport.git master
>
> and are intended for your master branch, aka the 1.5.3 series.
>
> Shawn O. Pearce (2):
>       Avoid src:dst syntax as default bash completion for git push
>       Import branch 'git-p4' of git://repo.or.cz/fast-export
>
> Yes, that's right, I pulled in Simon's git-p4 work.  :-)
>
> Benjamin Sergeant (1):  ...
> Han-Wen Nienhuys (30):  ...
> Kevin Green (1):        ...
> Marius Storm-Olsen (7): ...
> Simon Hausmann (222):   ...

I had an impression from reading #git log and mailing list
traffic, that you guys were afraid that the development history,
and especially the commit log messages on this branch, were, eh,
less than optimal.  So I got curious and took a look --- it does
not look too bad.  It is a nontrivial amount of code (1.5k lines
of Python) and is understandable to have meaningful history
behind it.

Pulled, and pushed out.
