From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Sat, 17 May 2014 02:24:13 -0400
Message-ID: <20140517062413.GA13003@sigill.intra.peff.net>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
 <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
 <20140516225228.GA3988@sigill.intra.peff.net>
 <5376f2ca5c90d_65b915db2f877@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 08:24:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlY2d-0001eS-MG
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 08:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756561AbaEQGYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 02:24:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:53635 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755136AbaEQGYP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 02:24:15 -0400
Received: (qmail 8510 invoked by uid 102); 17 May 2014 06:24:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 May 2014 01:24:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 May 2014 02:24:13 -0400
Content-Disposition: inline
In-Reply-To: <5376f2ca5c90d_65b915db2f877@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249440>

On Sat, May 17, 2014 at 12:25:30AM -0500, Felipe Contreras wrote:

> > I agree with the line of reasoning you laid out in your email,
> > especially:
> 
> What a shock.

Please stop with these unproductive and rude comments.

> > I hadn't thought of the rename idea, and it would address the concerns I
> > brought up. I do think "obsolete" is the wrong word, as it sends the
> > wrong message. The helpers are not obsolete; it is our _copy_ of them
> > that is.
> 
> Originally you said you would respect if I wanted the code out
> for v2.0, I said I would like it out at some point, not necessarily in
> v2.0. Junio said he was fine with that, but the proposals above don't do
> that.
> 
> Now it seems you are changing your mind and you are OK with the code
> remaining in.

My concerns were with people not noticing the README. Removing the code
entirely is the way I thought of to address that. Junio suggested
another way, which I would also be fine with. And it seems like a
friendlier way than removal to handle it for v2.0, if we are going to
remove the code entirely post-v2.0.

As before, if your desire is to have the code out for v2.0, then say so.
I think we should respect such a request.

-Peff
