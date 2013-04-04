From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] update pasky's email address
Date: Thu, 4 Apr 2013 12:32:58 +0200
Message-ID: <20130404103258.GI6137@machine.or.cz>
References: <20130404072123.GA6805@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marcin Owsiany <marcin@owsiany.pl>,
	Thomas Rast <trast@inf.ethz.ch>,
	Vojtech Pavlik <vojtech@suse.cz>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Apr 04 12:41:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNhbz-0001xc-Hr
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 12:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759873Ab3DDKlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 06:41:08 -0400
Received: from pasky.or.cz ([84.242.80.195]:58079 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759863Ab3DDKlG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 06:41:06 -0400
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Apr 2013 06:41:06 EDT
Received: by machine.or.cz (Postfix, from userid 2001)
	id E11851700058; Thu,  4 Apr 2013 12:32:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130404072123.GA6805@dcvr.yhbt.net>
 <20130404015042.GA19593@dcvr.yhbt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219996>

  Hi!

On Thu, Apr 04, 2013 at 01:50:42AM +0000, Eric Wong wrote:
> Mail to pasky@suse.cz is bouncing.

  Oh, I totally forgot to take care of this. Thanks a lot for fixing it!

> Signed-off-by: Eric Wong <normalperson@yhbt.net>

  In general, Acked-by: Petr Baudis <pasky@ucw.cz>

On Thu, Apr 04, 2013 at 07:21:23AM +0000, Eric Wong wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > Especially, a change like this:
> > 
> > > index db6eb50..e162ec9 100644
> > > --- a/gitweb/static/js/blame_incremental.js
> > > +++ b/gitweb/static/js/blame_incremental.js
> > > @@ -1,5 +1,5 @@
> > >  // Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
> > > -//               2007, Petr Baudis <pasky@suse.cz>
> > > +//               2007, Petr Baudis <pasky@ucw.cz>
> > 
> > makes me feel very uneasy and feels outright wrong; unless the
> > change by Petr in year 2007 was associated with the ucw.cz address,
> > not his then-current employer, that is.
> 
> I understand your concern.  Perhaps keeping the old address with
> a pointer to the current address?
> 
>              2007, Petr Baudis <pasky@suse.cz> (currently pasky@ucw.cz)
> 
> I'll wait for Petr's thoughts.

  Frankly, I have no idea how to handle this well; is this the first
time such a change has to happen in Git? Your proposed form seems
formally correct but feels a bit cumbersome to me. :-)

  I think that if SUSE would like the email address to stay in the
original form, the best way to confirm their preference would be to keep
it actually functional.  Maybe Vojtech will have some thoughts on
whether that would be possibe or whether we should keep the address
inact.

  Kind regards,

-- 
				Petr "Pasky" Baudis
	For every complex problem there is an answer that is clear,
	simple, and wrong.  -- H. L. Mencken
