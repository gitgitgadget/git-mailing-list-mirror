From: Jeff King <peff@peff.net>
Subject: Re: Our official home page and logo for the Git project
Date: Fri, 11 Apr 2014 07:40:18 -0400
Message-ID: <20140411114017.GC28858@sigill.intra.peff.net>
References: <xmqq7g6z4q6b.fsf@gitster.dls.corp.google.com>
 <534578b2e22e2_af197d3081@nysa.notmuch>
 <CAH5451kNoXobbh3-WBkewvKvNeFkV0P14Z55=qDN+Ak2WGkHSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 13:40:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYZor-0000TN-Do
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 13:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172AbaDKLkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 07:40:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:57870 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755051AbaDKLkU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 07:40:20 -0400
Received: (qmail 21850 invoked by uid 102); 11 Apr 2014 11:40:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Apr 2014 06:40:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Apr 2014 07:40:18 -0400
Content-Disposition: inline
In-Reply-To: <CAH5451kNoXobbh3-WBkewvKvNeFkV0P14Z55=qDN+Ak2WGkHSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246080>

On Thu, Apr 10, 2014 at 10:24:24AM +1000, Andrew Ardill wrote:

> It's normal for an organisation to have a collection of logos to
> choose from, with one 'official' version. For example, a black and
> white version is useful for print. Similarly, it's useful to have a
> couple of different contrast level/colours that can be used in the
> appropriate situations.

There are a few options at

  http://git-scm.com/downloads/logos

for matching the logo to the background.

> There is nothing wrong with having alternates that have been approved
> for various situations.

I'm not sure if this is how you meant it, but I want to emphasize that
there is no "approval" necessary for using alternate logos. Saying
"let's recognize this one as an official logo" is not meant to shut down
the use of others. It is only meant to say "when people ask for an
official logo (e.g., GSoC does so), this one is a good answer".

That is not to say that proliferation of logos is a good idea either.
The point of a logo is recognizability, and if there are dozens of git
logos, chances are that most of them are not recognizable.

> I recommend creating a git repository called git-resources,
> git-marketing, or git-assets, to contain the various approved logos.
> If there is not another location, or a more appropriate one,
> https://github.com/git would be a good place to put this.

I think the logo page above is a good start for variations of that
particular logo. I'd prefer not to put other random logos there unless
they also get wide enough use that they are recognized by the project.
But I have no objection to a repository of random logos.

The git-scm.com page is mostly targeted at end users: what is it, how do
I get it, where is the documentation. Things like a logo repository, or
developer information is spread across various wikis and other sites.
If there's interest, we can make "dev.git-scm.com" for such things, or
host repositories under http://github.com/git. But we would first need
content to put there, and somebody would need to step forward to
organize and maintain that content.

-Peff
