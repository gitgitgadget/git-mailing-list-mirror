From: Jeff King <peff@peff.net>
Subject: Re: git add -p and unresolved conflicts
Date: Thu, 29 Mar 2012 02:08:53 -0400
Message-ID: <20120329060853.GD27604@sigill.intra.peff.net>
References: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com>
 <7vbongyd67.fsf@alter.siamese.dyndns.org>
 <vpqvclozr7e.fsf@bauges.imag.fr>
 <4F73632E.1060408@ira.uka.de>
 <7vmx70v8ho.fsf@alter.siamese.dyndns.org>
 <4F736C17.4000403@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	kusmabite@gmail.com, Git Mailing List <git@vger.kernel.org>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Mar 29 08:09:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD8YC-0002WA-CQ
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 08:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310Ab2C2GI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 02:08:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36810
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036Ab2C2GI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 02:08:56 -0400
Received: (qmail 28052 invoked by uid 107); 29 Mar 2012 06:08:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Mar 2012 02:08:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2012 02:08:53 -0400
Content-Disposition: inline
In-Reply-To: <4F736C17.4000403@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194232>

On Wed, Mar 28, 2012 at 09:52:55PM +0200, Holger Hellmuth wrote:

> On 28.03.2012 21:19, Junio C Hamano wrote:
> >Holger Hellmuth<hellmuth@ira.uka.de>  writes:
> >
> >>I don't think it's that tricky:
> 
> I was assuming this "tricky" was about a sensible user interface.

I think maybe the discussion elsewhere in this thread has given you a
taste of the trickiness, but if you want to read more, here is a similar
discussion from the same time last year (ahh, Spring, when a young man's
thoughts turn to partial staging of conflicted hunks):

  http://thread.gmane.org/gmane.comp.version-control.git/168403/focus=168842

-Peff
