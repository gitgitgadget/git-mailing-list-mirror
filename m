From: Jeff King <peff@peff.net>
Subject: Re: Who is the 'git' vendor?
Date: Thu, 25 Oct 2012 05:10:17 -0400
Message-ID: <20121025091017.GE8390@sigill.intra.peff.net>
References: <8F7A9DADB4F4064EB938B0D3EBB63FDC208A5A34@PBNEMBMSX4120.int.Corp.sun>
 <5088FDDC.20404@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>,
	"'git@vger.kernel.org'" <git@vger.kernel.org>,
	"'Thor Home (thorlp@hotkey.net.au)'" <thorlp@hotkey.net.au>
To: "PROHASKA, Thor" <Thor.PROHASKA@suncorp.com.au>
X-From: git-owner@vger.kernel.org Thu Oct 25 11:10:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRJSY-000086-VV
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 11:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934849Ab2JYJKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 05:10:24 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55982 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934824Ab2JYJKU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 05:10:20 -0400
Received: (qmail 6623 invoked by uid 107); 25 Oct 2012 09:11:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Oct 2012 05:11:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2012 05:10:17 -0400
Content-Disposition: inline
In-Reply-To: <5088FDDC.20404@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208370>

On Thu, Oct 25, 2012 at 10:52:44AM +0200, Andreas Ericsson wrote:

> On 10/25/2012 08:43 AM, PROHASKA, Thor wrote:
> > Hi,
> > 
> > The organisation I am currently working for uses 'git'.
> > 
> > In order to manage all the software used in the organisation we have
> > been compiling a list of software that includes the software Vendor's
> > name.
> > 
> > My colleague has listed the vendor of git as being the 'Software
> > Freedom Conservancy'. Can you please advise me if this is correct? If
> > not, who should the vendor be identified as?
> > 
> 
> Most likely, you'll want to put "git@vger.kernel.org" as vendor for git,
> as the whole vendor concept doesn't really fly with FOSS. There's noone
> to go to if it breaks your systems, and unless you purchase a support
> contract from somewhere there's noone to turn to except the (excellent)
> git community in case you have issues with it.

Yeah. Depending on the purpose of the list, I would probably _not_ put
the SFC. They help manage the legal and financial aspects of the git
project, but they have nothing at all to do with the code itself. I
would hate for them to get a phone call about support. :)

Probably "The Git Community" or "git@vger.kernel.org" is the best thing
to fill in if you need to write something in a form. If there ends up
being some specific reason for a vendor to be contacted, folks on the
list will be able to point an inquiry in the right direction (which
might even end up being the SFC).

-Peff
