From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation: enhanced "git for CVS users" doc about
	shared repositories
Date: Wed, 7 Nov 2007 12:32:17 -0500
Message-ID: <20071107173217.GB10525@fieldses.org>
References: <472F99F8.4010904@gmail.com> <7v8x5cmern.fsf@gitster.siamese.dyndns.org> <4730E056.7080809@gmail.com> <7vd4unez2l.fsf@gitster.siamese.dyndns.org> <47310ACF.4030103@gmail.com> <Pine.LNX.4.64.0711070053320.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francesco Pretto <ceztkoml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 18:32:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipolh-00015i-Qb
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 18:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249AbXKGRca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 12:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755237AbXKGRca
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 12:32:30 -0500
Received: from mail.fieldses.org ([66.93.2.214]:35051 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754856AbXKGRc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 12:32:29 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IpolF-0005YF-B1; Wed, 07 Nov 2007 12:32:17 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711070053320.4362@racer.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63843>

On Wed, Nov 07, 2007 at 12:55:49AM +0000, Johannes Schindelin wrote:
> Remember, those who read "git for CVS users" are _unwilling_ to spend the 
> time reading git documentation (at least for the most part).  If they 
> encounter something which is not useful to them, they will not just ignore 
> it, they will stop reading.

That might overstate the case a little, but I definitely agree that we
should get people to the information they need as quickly as possible,
and that adding more beginning-unix-administration will interfere with
that goal for the intended audience.

And it's not just here--there's probably lots of basic unix-commandline
stuff that we could include with the user-manual (how find/xargs pipes
work, etc...), and that would similarly help one possible audience at
the expense of bogging it down for another audience.

I think the way to help people without those prerequisites is by clearer
statements of prerequisites, and references to documentation elsewhere
where appropriate.

--b.
