From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 3/5] Create a git.Branch class as ancestor of stack.Stack
Date: Mon, 9 Jun 2008 09:07:22 +0200
Message-ID: <20080609070722.GA4100@diana.vm.bytemark.co.uk>
References: <20080604210655.32531.82580.stgit@localhost.localdomain> <20080604211334.32531.74258.stgit@localhost.localdomain> <20080605070126.GC23209@diana.vm.bytemark.co.uk> <b0943d9e0806050503x40191104ye332d6a8435811a5@mail.gmail.com> <20080605130415.GB28995@diana.vm.bytemark.co.uk> <b0943d9e0806060144x48176566m277ba2969087b91e@mail.gmail.com> <20080607090636.GB32647@diana.vm.bytemark.co.uk> <b0943d9e0806081516y575faba9g8b5a27646615f72f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 09:08:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5bUT-0006SU-QR
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 09:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784AbYFIHHg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jun 2008 03:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbYFIHHg
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 03:07:36 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4749 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbYFIHHg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 03:07:36 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K5bTO-000157-00; Mon, 09 Jun 2008 08:07:22 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0806081516y575faba9g8b5a27646615f72f@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84365>

On 2008-06-08 23:16:02 +0100, Catalin Marinas wrote:

> Hidden plan - once the new stgit.lib.git module is complete, we can
> advertise it as a stand-alone object-oriented Git wrapper for Python
> :-).

Aren't there already a couple of those? :-)

Though I agree that having such a future separation in mind is useful
for making StGit nice and modular. Whether we actually carry it out in
the end would depend on whether someone comes along and actually wants
to use it, I guess.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
