From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] Re-roll rr/triangle
Date: Tue, 2 Apr 2013 13:52:25 -0400
Message-ID: <20130402175225.GE24698@sigill.intra.peff.net>
References: <1364888434-30388-1-git-send-email-artagnon@gmail.com>
 <20130402135813.GA23828@sigill.intra.peff.net>
 <7vobdwetaj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 19:53:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN5OI-0007c9-Im
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761467Ab3DBRwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 13:52:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52399 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761445Ab3DBRwa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 13:52:30 -0400
Received: (qmail 11959 invoked by uid 107); 2 Apr 2013 17:54:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 13:54:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 13:52:25 -0400
Content-Disposition: inline
In-Reply-To: <7vobdwetaj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219821>

On Tue, Apr 02, 2013 at 10:28:20AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Apr 02, 2013 at 01:10:28PM +0530, Ramkumar Ramachandra wrote:
> >
> >> Jeff King (1):
> >>   t5516 (fetch-push): drop implicit arguments from helper functions
> >> 
> >> Ramkumar Ramachandra (5):
> >>   remote.c: simplify a bit of code using git_config_string()
> >>   t5516 (fetch-push): update test description
> >>   remote.c: introduce a way to have different remotes for fetch/push
> >>   remote.c: introduce remote.pushdefault
> >>   remote.c: introduce branch.<name>.pushremote
> >
> > Thanks; I didn't see any problems in this round.
> 
> Can I turn that into 5 Reviewed-by's?

Yes, please do. Six if you want me to review my own patch. :)

-Peff
