From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Keep committer and committer dates
Date: Wed, 4 Jun 2008 12:29:06 +0200
Message-ID: <20080604102906.GA2126@diana.vm.bytemark.co.uk>
References: <Pine.LNX.4.61.0806031647320.1798@tm8103-a.perex-int.cz> <alpine.DEB.1.00.0806032115340.13507@racer.site.net> <Pine.LNX.4.61.0806041113520.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
X-From: git-owner@vger.kernel.org Wed Jun 04 12:30:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3qFw-0000AY-FE
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 12:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbYFDK3U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2008 06:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753043AbYFDK3T
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 06:29:19 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2623 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbYFDK3T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 06:29:19 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K3qEs-000170-00; Wed, 04 Jun 2008 11:29:06 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0806041113520.1798@tm8103-a.perex-int.cz>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83769>

On 2008-06-04 11:16:46 +0200, Jaroslav Kysela wrote:

> On Tue, 3 Jun 2008, Johannes Schindelin wrote:
>
> > That feels really funny, given that the guy running git-am _is_
> > the committer, not whoever provided some extra headers to the
> > mailbox.
>
> Yes, the implementatation does not make sense for public patch
> handling, but if you do various things locally with git-rebase or
> git-am (pack picking from another repo), you may consider it useful.

But still, you're creating new commits, so they should have your name
on them.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
