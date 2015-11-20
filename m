From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/7] Modernize t9300-fast-import
Date: Fri, 20 Nov 2015 06:22:23 -0500
Message-ID: <20151120112223.GD11198@sigill.intra.peff.net>
References: <cover.1447959452.git.j6t@kdbg.org>
 <CAPig+cSH+BnvnzVY=YhRknynyWkAdbXNMvvrb7GcjEnf6UDFug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 12:22:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zzjlx-0005hb-F5
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 12:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759890AbbKTLW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 06:22:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:60062 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759882AbbKTLW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 06:22:26 -0500
Received: (qmail 18215 invoked by uid 102); 20 Nov 2015 11:22:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 05:22:26 -0600
Received: (qmail 26465 invoked by uid 107); 20 Nov 2015 11:22:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 06:22:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Nov 2015 06:22:23 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cSH+BnvnzVY=YhRknynyWkAdbXNMvvrb7GcjEnf6UDFug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281507>

On Thu, Nov 19, 2015 at 10:54:11PM -0500, Eric Sunshine wrote:

> On Thu, Nov 19, 2015 at 2:09 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> > Some time ago, I had to dig into t9300-fast-import and found it quite
> > unhelpful that it does not follow our modern best-practices. This series
> > brings it up-to-date. I thought I submit it now while it is quiet in
> > the area.
> >
> > The larger patches are best viewed using -w -color-words because the
> > regular patch text is ... overwhelming.
> 
> For what it's worth, I read through the series (with care, I hope) and
> didn't find anything amiss.

Thanks, both. I gave it a quick read and didn't see anything wrong. The
end result is certainly nicer to read. :)

-Peff
