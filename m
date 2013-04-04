From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] update pasky's email address
Date: Thu, 4 Apr 2013 07:21:23 +0000
Message-ID: <20130404072123.GA6805@dcvr.yhbt.net>
References: <20130404015042.GA19593@dcvr.yhbt.net>
 <7v38v6lrrk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org,
	Marcin Owsiany <marcin@owsiany.pl>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 09:21:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNeUa-0001wA-Ko
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 09:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763567Ab3DDHVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 03:21:24 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42388 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840Ab3DDHVX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 03:21:23 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C7241F434;
	Thu,  4 Apr 2013 07:21:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v38v6lrrk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219991>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Mail to pasky@suse.cz is bouncing.
> >
> > Signed-off-by: Eric Wong <normalperson@yhbt.net>
> > ---
> >  I noticed this when I attempted to reply to Thomas's email:
> >  http://mid.gmane.org/f3d238a4c6cfbc6d68f2c4fa285aefa93acf4b7d.1365027616.git.trast@inf.ethz.ch
> >
> >  .mailmap                                            | 1 +
> 
> Thanks, but I wonder if an entry update to .mailmap alone is
> sufficient.

Gah, and somehow I got "suse.de" burned into my brain and screwed up
the .mailmap entry (should have been "suse.cz") :x

> Especially, a change like this:
> 
> > index db6eb50..e162ec9 100644
> > --- a/gitweb/static/js/blame_incremental.js
> > +++ b/gitweb/static/js/blame_incremental.js
> > @@ -1,5 +1,5 @@
> >  // Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
> > -//               2007, Petr Baudis <pasky@suse.cz>
> > +//               2007, Petr Baudis <pasky@ucw.cz>
> 
> makes me feel very uneasy and feels outright wrong; unless the
> change by Petr in year 2007 was associated with the ucw.cz address,
> not his then-current employer, that is.

I understand your concern.  Perhaps keeping the old address with
a pointer to the current address?

             2007, Petr Baudis <pasky@suse.cz> (currently pasky@ucw.cz)

I'll wait for Petr's thoughts.
