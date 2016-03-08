From: Jeff King <peff@peff.net>
Subject: Re: Git has been accepted as a GSoC 2016 mentor organization!
Date: Tue, 8 Mar 2016 17:46:26 -0500
Message-ID: <20160308224625.GA29922@sigill.intra.peff.net>
References: <448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com>
 <vpqh9h7f9kz.fsf@anie.imag.fr>
 <xmqq60xnjh1s.fsf@gitster.mtv.corp.google.com>
 <vpqziuzdr5r.fsf@anie.imag.fr>
 <20160217204528.GA22893@sigill.intra.peff.net>
 <xmqq60xnhviw.fsf@gitster.mtv.corp.google.com>
 <1455788324.3786.14.camel@dwim.me>
 <vpq1t896s5c.fsf_-_@anie.imag.fr>
 <1455875178.343346.31.camel@dwim.me>
 <vpq4mcr8c3j.fsf_-_@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 08 23:46:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adQOg-0002FS-Qw
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 23:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbcCHWqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 17:46:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:56631 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751107AbcCHWqa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 17:46:30 -0500
Received: (qmail 2222 invoked by uid 102); 8 Mar 2016 22:46:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Mar 2016 17:46:29 -0500
Received: (qmail 8189 invoked by uid 107); 8 Mar 2016 22:46:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Mar 2016 17:46:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Mar 2016 17:46:26 -0500
Content-Disposition: inline
In-Reply-To: <vpq4mcr8c3j.fsf_-_@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288455>

On Mon, Feb 29, 2016 at 10:01:52PM +0100, Matthieu Moy wrote:

> Hi,
> 
> This is my pleasure to inform you all that Git has just been accepted as
> a GSoC mentor organization.
> 
>   https://summerofcode.withgoogle.com/organizations/?sp-page=3
> 
> I've invited Johannes, Stefan, Christian and Lars as potential mentors
> for Git, and Carlos to represent libgit2. I also took the freedom to
> invite Junio, not really as potential mentor, but to give access to
> students proposals and give an opportunity to comment.
> 
> Let me (or Peff) know if you want an invitation too. No commitment to
> mentor anyone for now if you accept the invitation, this will be decided
> later.
> 
> As a reminder, we post all the GSoC related stuff here:
> 
>   http://git.github.io/SoC-2016-Ideas/
>   http://git.github.io/SoC-2016-Microprojects/

I've also signed us up for Outreachy, which is an internship program
designed to encourage open source participation by under-represented
groups. Details are here:

  https://www.gnome.org/outreachy/

but I'll try to summarize here what it means for us.

It's similar to GSoC and runs during the same time frame. It's open to
non-students (so some people who could not do GSoC can apply), but
applications must be from one of the under-represented groups listed at
the link above. People can apply to both if they are eligible, but can
only be accepted to one. As Outreachy is advertised in certain circles
where GSoC is not (or where people might be intimidated by GSoC), my
hope is we can drive some more diversity in GSoC applicants (not to
mention catching people who don't qualify for GSoC because they aren't
following traditional education paths).

The catch is that Outreachy doesn't provide the stipend money; the
projects have to find their own funding. I don't think this should be a
big problem for Git. I have some leads we can follow if we get an
Outreachy intern (and obviously if they are accepted through GSoC, it's
a non-issue).

I've put up a landing page for our participation here:

  http://git.github.io/Outreachy-2016-May/

Comments/patches welcome.

Most of the resources are just pointers to our GSoC stuff. This does
mean I've effectively signed our mentors up to participate in this
program.  I hope that's OK, as it's effectively the same commitment as
GSoC (and obviously we would spread our mentoring resources over the
total pool of applicants between both programs, and not double-book any
mentors).

And finally, I'm sorry to spring this on the list as a fait accompli.
One of the leaders of Outreachy contacted me, Junio, and Shawn off-list
asking if we'd like to participate. We agreed it sounded reasonable, but
we have to move reasonably quickly, as the application period has
already begun (it runs until March 22). That's why I've taken the
initial steps independently. But if anybody has comments, or is
violently opposed, please don't take my actions as an attempt to skip
the discussion phase. :)

-Peff
