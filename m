From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 00/19] Enable options --signoff, --reset-author for
 pick, reword
Date: Sat, 2 Aug 2014 09:52:55 -0400
Message-ID: <20140802135255.GA4185@peff.net>
References: <53A258D2.7080806@gmail.com>
 <cover.1406589435.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 15:53:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDZkH-0005WO-0u
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 15:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbaHBNxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2014 09:53:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:44806 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754606AbaHBNxH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2014 09:53:07 -0400
Received: (qmail 23212 invoked by uid 102); 2 Aug 2014 13:53:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 02 Aug 2014 08:53:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Aug 2014 09:52:55 -0400
Content-Disposition: inline
In-Reply-To: <cover.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254699>

On Tue, Jul 29, 2014 at 01:18:00AM +0200, Fabian Ruch wrote:

> this is a reroll of the patch series that enables rudimentary support
> of line options for git-rebase's to-do list commands and reimplements
> the well-known commands `reword` and `squash` in terms of a
> parameterised `do_pick`.

I just finished reading over the whole series (which is my first real
exposure to it). With the exception of the comments I already sent, it
looks pretty reasonable to me.

Thanks for splitting it and writing good commit messages; that made it
relatively easy to follow what was going on.

-Peff
