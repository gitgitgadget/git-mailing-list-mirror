From: Jeff King <peff@peff.net>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz
 origin/frotz"
Date: Sun, 6 Jun 2010 12:18:05 -0400
Message-ID: <20100606161805.GA6239@coredump.intra.peff.net>
References: <20100605110930.GA10526@localhost>
 <AANLkTilbg2nGr_sVmJLboMgXbas_qsB4V6gYxDxcDgKy@mail.gmail.com>
 <20100605135811.GA14862@localhost>
 <AANLkTikE5BPD_DDqwEvPGxsMAIQCulpVwRKaCSnULcoP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Peter Rabbitson <ribasushi@cpan.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 06 18:18:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLIYC-0008TZ-AC
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 18:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934112Ab0FFQSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 12:18:11 -0400
Received: from peff.net ([208.65.91.99]:34404 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932198Ab0FFQSK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 12:18:10 -0400
Received: (qmail 8527 invoked by uid 107); 6 Jun 2010 16:18:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Jun 2010 12:18:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jun 2010 12:18:05 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikE5BPD_DDqwEvPGxsMAIQCulpVwRKaCSnULcoP@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148523>

On Sat, Jun 05, 2010 at 04:03:30PM +0200, Sverre Rabbelier wrote:

> On Sat, Jun 5, 2010 at 15:58, Clemens Buchacher <drizzd@aon.at> wrote:
> > Well, I just noticed this by accident, it is not documented
> > anywhere, and you cannot expected me to know everything that is
> > going on on the list. Should I not offer my opinion because of
> > that?
> 
> No, I just meant that because you are late to the party you should
> first read the original thread, and then perhaps summarize it, like
> you have done below.

Moreover, the burden for arguing against it is a little higher. It is no
longer "I think this is a bad idea" but "I think this is a bad idea, and
it is so bad that it is worth changing behavior that users may have
become accustomed to".

> > Well, I also think it is a bad idea, and I am not surprised to find
> > users confused by it.
> 
> I think it was an idea from the last mentor summit, Peff?

No, I complained about it at the mentor summit, but the idea predates
it. I think all of the relevant discussion is on the list.

-Peff
