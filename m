From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2013, #07; Tue, 26)
Date: Wed, 27 Mar 2013 16:52:47 -0400
Message-ID: <20130327205247.GA8613@sigill.intra.peff.net>
References: <7v620dss3j.fsf@alter.siamese.dyndns.org>
 <20130327203535.GA5220@sigill.intra.peff.net>
 <7vd2uklg8a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 21:53:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKxLu-0005i3-Jn
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 21:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618Ab3C0Uwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 16:52:54 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41924 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753514Ab3C0Uww (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 16:52:52 -0400
Received: (qmail 18884 invoked by uid 107); 27 Mar 2013 20:54:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Mar 2013 16:54:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Mar 2013 16:52:47 -0400
Content-Disposition: inline
In-Reply-To: <7vd2uklg8a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219331>

On Wed, Mar 27, 2013 at 01:50:29PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I was kind of surprised to see this still in pu, too. I thought it was
> > supposed to cook in next for a while to shake out any interoperability
> > bugs (and it was in next previously). Did it get ejected after the
> > release and then never put back?
> 
> Yes, I've been trying to concentrate on flushing safer and older
> ones first to 'master', and I _think_ I am more or less finished
> with that as of last night.  Many will come back to 'next' in
> today's integration run.

Thanks, I figured it was something like that, but was puzzled.

-Peff
