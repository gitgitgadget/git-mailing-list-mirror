From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH 4/5] Documentation: reset: describe new "--keep" option
Date: Tue, 19 Jan 2010 05:28:54 +0100
Message-ID: <201001190528.54642.chriscool@tuxfamily.org>
References: <20100102053303.30066.26391.chriscool@tuxfamily.org> <20100102053934.30066.76552.chriscool@tuxfamily.org> <20100102171422.GA19522@panix.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Daniel Convissor <danielc@analysisandsolutions.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 05:26:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX5fS-0007Pi-3b
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 05:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115Ab0ASE0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 23:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753173Ab0ASE0H
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 23:26:07 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53886 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932122Ab0ASE0C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 23:26:02 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id DB13481805A;
	Tue, 19 Jan 2010 05:25:51 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0909D818028;
	Tue, 19 Jan 2010 05:25:49 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20100102171422.GA19522@panix.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137423>

On samedi 02 janvier 2010, Daniel Convissor wrote:
> On Sat, Jan 02, 2010 at 06:39:32AM +0100, Christian Couder wrote:
> > +++ b/Documentation/git-reset.txt
>
> ...
>
> > +--keep::
> > +	Resets the index to match the tree recorded by the named commit,
> > +	but keep changes in the working tree. Aborts if the reset would
> > +	change files that are already changes in the working tree.
>
> Grammar suggestion for the last line there.  Change "already changes" to
> "already changed".  Or better yet, use a different word, such as "already
> modified", since "change" based words have been used so many times
> already in the sentence.

Ok I used "already modified".

Thanks,
Christian.
