From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 05/11] Makefile: do not replace @@GIT_USER_AGENT@@ in
 scripts
Date: Wed, 20 Jun 2012 16:09:07 -0400
Message-ID: <20120620200906.GA1397@sigill.intra.peff.net>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183142.GE30995@sigill.intra.peff.net>
 <7vobodu4sj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 22:09:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShRDH-0004ju-QN
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 22:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758013Ab2FTUJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 16:09:11 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39216
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636Ab2FTUJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 16:09:10 -0400
Received: (qmail 29311 invoked by uid 107); 20 Jun 2012 20:09:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 16:09:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 16:09:07 -0400
Content-Disposition: inline
In-Reply-To: <7vobodu4sj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200355>

On Wed, Jun 20, 2012 at 01:06:20PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > No scripts actually care about this replacement. This was
> > erroneously added by d937411.
> 
> d937411???

Whoops. That's the version in my local repo (from which I sent a patch
that you applied). The version in your repo is 42dcbb7.

-Peff
