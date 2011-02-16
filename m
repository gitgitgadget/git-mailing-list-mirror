From: Jeff King <peff@peff.net>
Subject: Re: non-empty index with git commit -a
Date: Wed, 16 Feb 2011 14:59:31 -0500
Message-ID: <20110216195931.GA22884@sigill.intra.peff.net>
References: <20110216032047.GA2858@elie>
 <AANLkTinbcHW+ja7T=PiCEorNdnK6W2DvA_c9F8JTEMKB@mail.gmail.com>
 <20110216085114.GA9413@sigill.intra.peff.net>
 <AANLkTik_F=d1CjNVfj35wgv0pL1LefOMnttXjs=s2wCQ@mail.gmail.com>
 <20110216095415.GA12578@sigill.intra.peff.net>
 <AANLkTimj9NCR2Kkiz82WW1qx1NY-ptS4Qn2yzPqoLGP0@mail.gmail.com>
 <20110216100622.GA12971@sigill.intra.peff.net>
 <7vpqqrke30.fsf@alter.siamese.dyndns.org>
 <20110216193643.GB22045@sigill.intra.peff.net>
 <7v1v37kb3p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 21:00:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpnXr-0005I4-5D
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 21:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221Ab1BPT7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 14:59:53 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:45152 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754018Ab1BPT7e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 14:59:34 -0500
Received: (qmail 13512 invoked by uid 111); 16 Feb 2011 19:59:33 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 16 Feb 2011 19:59:33 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Feb 2011 14:59:31 -0500
Content-Disposition: inline
In-Reply-To: <7v1v37kb3p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166996>

On Wed, Feb 16, 2011 at 11:55:54AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But as I said, I am not against a config option if it is such a common
> > problem. I certainly would not turn it on. And I don't think it should
> > be on by default.
> 
> I think we are pretty much on the same page, except that I am not very
> interested in the index-log either.

To be fair, I am not sure I am that interested in the index-log either.
I just see it as a superior solution to the same problem, but I don't
consider it a very important problem.

So I think we are really on the same page. :)

-Peff
