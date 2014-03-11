From: Jeff King <peff@peff.net>
Subject: Re: GSoC idea: allow "git rebase --interactive" todo lines to take
 options
Date: Mon, 10 Mar 2014 21:37:49 -0400
Message-ID: <20140311013749.GA12033@sigill.intra.peff.net>
References: <530DA00E.4090402@alum.mit.edu>
 <20140226105249.GE25711@sigill.intra.peff.net>
 <CANUGeEY2qE2LPq=-bhaKrKrv+uJUaPRqAeW_X1sFyZH-_PRVeA@mail.gmail.com>
 <20140228125241.GA23448@sigill.intra.peff.net>
 <53109748.3090507@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon McCaig <bamccaig@gmail.com>,
	git discussion list <git@vger.kernel.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 11 02:37:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNBdk-0002Pq-G0
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 02:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbaCKBhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 21:37:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:36972 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752323AbaCKBhv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 21:37:51 -0400
Received: (qmail 3382 invoked by uid 102); 11 Mar 2014 01:37:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Mar 2014 20:37:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Mar 2014 21:37:49 -0400
Content-Disposition: inline
In-Reply-To: <53109748.3090507@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243831>

On Fri, Feb 28, 2014 at 03:03:52PM +0100, Michael Haggerty wrote:

> > I'm not sure whether it is a good idea or not. But I think it is looking
> > decreasingly like a good GSoC project.
> 
> I guess I misread the sentiment of the mailing list, because I merged
> this idea into the list about two hours ago.

Yeesh, sorry to be so slow on the reply to this. It floated to the
bottom of my "to respond" list.

> But if you think that even the proposal's simpler sub-ideas are
> controversial, then let me know and I will delete the idea from the list
> again.  I don't want a GSoC student to have to fight battles of my own
> creation :-)

I'd say keep it at this point. I think there _are_ some good ideas here,
and part of a project is figuring out what is good. And part of the role
of the mentor is applying some taste. There are probably students who
would be a good fit, and students who would not. That is true for just
about every project, of course, but I think this one is just a little
trickier than some.

-Peff
