From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] rebase: new convenient option to edit a single commit
Date: Fri, 28 Feb 2014 02:38:26 -0500
Message-ID: <20140228073826.GA32496@sigill.intra.peff.net>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
 <20140228065802.GB31731@sigill.intra.peff.net>
 <CACsJy8BC089h3j4H-DV5+BdhK74=k4v+=vO6a26xRJ==BLJ3-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 08:38:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJI1h-00075y-Ba
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 08:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbaB1Hi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 02:38:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:58539 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751232AbaB1Hi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 02:38:29 -0500
Received: (qmail 13888 invoked by uid 102); 28 Feb 2014 07:38:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Feb 2014 01:38:29 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Feb 2014 02:38:26 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8BC089h3j4H-DV5+BdhK74=k4v+=vO6a26xRJ==BLJ3-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242901>

On Fri, Feb 28, 2014 at 02:34:16PM +0700, Duy Nguyen wrote:

> > Yeah, I do this a lot, too.  The interface you propose makes sense to
> > me, though I'm not sure how much I would use it, as I often do not know
> > the specifier of the commit I want to change (was it "HEAD~3 or
> > HEAD~4?"). I guess using ":/" could make that easier.
> 
> In my case, I just copy/paste the commit ID from "git log -lp". I
> think :/ already works with rebase..

I think it should work. I just meant "I will have to get in the habit of
starting to use :/". :)

-Peff
