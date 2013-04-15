From: Jeff King <peff@peff.net>
Subject: Re: Ensimag students projects, version 2013
Date: Mon, 15 Apr 2013 10:05:13 -0400
Message-ID: <20130415140513.GA16154@sigill.intra.peff.net>
References: <vpqobdg515m.fsf@grenoble-inp.fr>
 <87r4iccgdw.fsf@linux-k42r.v.cablecom.net>
 <vpqvc7oqh8a.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 15 16:05:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URk2C-0005mq-UX
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 16:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660Ab3DOOFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 10:05:24 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46537 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327Ab3DOOFX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 10:05:23 -0400
Received: (qmail 23734 invoked by uid 107); 15 Apr 2013 14:07:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Apr 2013 10:07:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Apr 2013 10:05:13 -0400
Content-Disposition: inline
In-Reply-To: <vpqvc7oqh8a.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221232>

On Mon, Apr 15, 2013 at 11:24:21AM +0200, Matthieu Moy wrote:

> > * git pull --set-upstream
> >
> >   This is vaguely related to another itch that nobody has bothered to
> >   fix: 'git fetch origin foo' should really update origin/foo.  This has
> >   been discussed on the list a few times already:
> >
> >     http://thread.gmane.org/gmane.comp.version-control.git/192252
> >     http://thread.gmane.org/gmane.comp.version-control.git/165720/focus=165758
> >
> >   which by the way would be a *great* thing to fix, hint hint ;-)  and
> >   since Peff already posted a POC patch in the first thread, it's
> >   probably not that hard.  (Peff?)
> 
> My understanding is that this would be technically easy to fix, but a
> migration plan is needed, which isn't easy for a one-shot, one-month
> contribution.

Yes. The concept isn't that hard, but the question was one of whether it
would break some obscure workflows. But I don't remember all of the
details; I think I gave some examples in past threads.

-Peff
