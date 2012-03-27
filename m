From: Jeff King <peff@peff.net>
Subject: Re: [RFH] SoC 2012 Guidelines
Date: Tue, 27 Mar 2012 01:57:47 -0400
Message-ID: <20120327055747.GB24170@sigill.intra.peff.net>
References: <201203241711.30270.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 07:58:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCPPp-0003gk-65
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 07:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756197Ab2C0F5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 01:57:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33934
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755836Ab2C0F5w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 01:57:52 -0400
Received: (qmail 31363 invoked by uid 107); 27 Mar 2012 05:58:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Mar 2012 01:58:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2012 01:57:47 -0400
Content-Disposition: inline
In-Reply-To: <201203241711.30270.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194015>

On Sat, Mar 24, 2012 at 05:11:29PM +0100, Jakub Narebski wrote:

> The https://github.com/peff/git/wiki/ includes the following pages:
> 
> * "SoC 2012 Application", which should probably be renamed to
>   "SoC 2012 Organization Application"; it was here to help (crowd)craft
>   organization application.
> 
> * "SoC 2012 Template", which perhaps should be better named
>   "SoC 2012 Student Application Template"; it is here for prospective
>   (would-be) student to help craft better project application.

Good renaming suggestions; I just pushed this.

The template page was not well-advertised, so I linked to it from the
ideas page.

> What is lacking (for me) is something like "SoC 2012 Guidelines" wiki
> page, which would gather guidelines and suggestions both for mentors
> and for students.

Some of that (for the students) is at the ideas page, and on the
application template page. To a large degree, the advice is: engage the
community. Hopefully that results in interesting discussions and the
students getting a sense of what is required for each project.  But
there is probably room to provide some more specific guidance.

For the mentor side, we have pretty much left the mentors alone to
decide how to do their jobs, recognizing that every mentor and every
student-mentor pair will be a little bit different.

> This page could also serve to gather organization-specific requirements,
> for example:
> [...]

All of what you said looks reasonable to me, and follows the practices
we've had in years past. It's a wiki. Feel free to add a new page, or
edit (or if you want to get feedback before changing the wiki, post
patches).

> And to gather help:
> 
> * There should be some information about what parts of discussion and
>   work should take place in private communication between student and
>   mentor, and how much should it take place in public, on git mailing
>   list.
> 
> * How can and how should mentors help students.
> 
> * How to make use of comments on patches (or design ideas), while not
>   getting bogged down in "bikeshed"-ding :-)
> 
> * Perhaps also some advice from successfull students to students,
>   and from mentors to mentors.

Some of these things are discussed in more general terms on the GSoC
mentors list. We don't have particular policies in git, though in general
I would encourage mentors to integrate the students into the usual list
workflow. So lots of communication and status reports, and as much as
possible in the open and on the list.

-Peff
