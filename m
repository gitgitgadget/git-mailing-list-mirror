From: Jeff King <peff@peff.net>
Subject: Re: Promoting Git developers
Date: Thu, 12 Mar 2015 18:43:51 -0400
Message-ID: <20150312224351.GC24492@peff.net>
References: <CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
 <xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
 <CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
 <xmqqmw3kuuod.fsf@gitster.dls.corp.google.com>
 <20150311073129.GA5947@peff.net>
 <CAPc5daUVVk+SYgwCj9JftzXgV7=9kPprdBPCWHS5XQOa5uF69Q@mail.gmail.com>
 <20150311075429.GA10300@peff.net>
 <xmqqbnjz5in0.fsf@gitster.dls.corp.google.com>
 <20150312223131.GA24492@peff.net>
 <xmqqd24d2681.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Jason St. John" <jstjohn@purdue.edu>,
	Christian Couder <christian.couder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 23:44:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWBpf-00076w-5Y
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 23:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbbCLWny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 18:43:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:60731 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750848AbbCLWny (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 18:43:54 -0400
Received: (qmail 14670 invoked by uid 102); 12 Mar 2015 22:43:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Mar 2015 17:43:53 -0500
Received: (qmail 7161 invoked by uid 107); 12 Mar 2015 22:44:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Mar 2015 18:44:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Mar 2015 18:43:51 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd24d2681.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265380>

On Thu, Mar 12, 2015 at 03:36:46PM -0700, Junio C Hamano wrote:

> > I hadn't thought about it when I originally suggested this, but of
> > course "new" is not strictly meaningful in a world with branches. If you
> > contribute a bugfix on top of v2.0.0 that goes to "maint", do you get to
> > be new in v2.0.1 _and_ in v2.2.0?
> 
> Yeah, tricky.  How about
> 
>     New contributors whose contributions weren't in $previous are as follows.
>     Welcome to the Git development community!

Yeah, that makes a lot of sense to me, and then we can have it in both
places. I suspect the releases from "master" get a lot more readers, but
if we had to pick only one, people with bugfixes would generally be
mentioned in "maint" announcements.

-Peff
