From: Jeff King <peff@peff.net>
Subject: Re: Globbing for ignored branches?
Date: Fri, 24 Jan 2014 13:55:38 -0500
Message-ID: <20140124185538.GA9836@sigill.intra.peff.net>
References: <20140124090104.GA396@x4>
 <0C723FEB5B4E5642B25B451BA57E273075148284@S1P5DAG3C.EXCHPROD.USA.NET>
 <20140124170739.GC396@x4>
 <20140124170909.GD396@x4>
 <20140124182341.GB8202@sigill.intra.peff.net>
 <20140124183222.GE396@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jim Garrison <jim.garrison@nwea.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Markus Trippelsdorf <markus@trippelsdorf.de>
X-From: git-owner@vger.kernel.org Fri Jan 24 19:55:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6lur-0007Wc-A9
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 19:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbaAXSzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 13:55:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:38309 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751789AbaAXSzk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 13:55:40 -0500
Received: (qmail 1645 invoked by uid 102); 24 Jan 2014 18:55:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Jan 2014 12:55:40 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jan 2014 13:55:38 -0500
Content-Disposition: inline
In-Reply-To: <20140124183222.GE396@x4>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241021>

On Fri, Jan 24, 2014 at 07:32:22PM +0100, Markus Trippelsdorf wrote:

> > However, you do have to specify each branch individually. You probably
> > want to say "all branches except X", and you cannot currently specify
> > a negative refspec like that.
> 
> Yes, that was the question I wanted to ask (, sorry for not formulating
> it more clearly). 
> Is this "negative refspec for branches" a feature that is planned for
> the future?

It is something that has been talked about before, but I do not think
anybody is actively working on. It would probably not be too hard a
feature if you are interested in getting your feet wet in git
development. :)

-Peff
