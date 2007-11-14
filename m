From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual.txt: fix a few mistakes
Date: Wed, 14 Nov 2007 14:44:31 -0500
Message-ID: <20071114194431.GO14254@fieldses.org>
References: <87bq9x7w4d.fsf@osv.gnss.ru> <20071114181858.GH14254@fieldses.org> <7v8x50hawk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 20:45:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsOB7-0001gn-1F
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 20:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279AbXKNTof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 14:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755243AbXKNToe
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 14:44:34 -0500
Received: from mail.fieldses.org ([66.93.2.214]:56090 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753929AbXKNToe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 14:44:34 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IsOA3-0000ps-Mm; Wed, 14 Nov 2007 14:44:31 -0500
Content-Disposition: inline
In-Reply-To: <7v8x50hawk.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65001>

On Wed, Nov 14, 2007 at 11:42:03AM -0800, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > I actually prefer "head" here.  On something like:
> >
> > 		 A--B--C
> > 		/
> > 	o--o--o
> > 		\
> > 		 o--o--o
> >
> >
> > The term "branch" could be used to refer to the whole line of
> > development consisting of A, B, and C.  The term "head", on the other
> > hand, refers to either C or a ref that points to it.  We also use the
> > terms "branch head" or just "branch" for that case, but I think "head"
> > is more precise.
> >
> >> +This lists the commits reachable from the previous version of the branch.
> >> +This syntax can be used with any git command that accepts a commit,
> >>  not just with git log.  Some other examples:
> >
> > (Otherwise looks fine, thanks!)
> 
> Oops, I think I skipped the hunk #2 and applied hunk #3.  Will
> fix-up with:

OK, thanks Junio!

--b.
