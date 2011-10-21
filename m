From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] contrib: add git-jump script
Date: Fri, 21 Oct 2011 13:35:28 -0400
Message-ID: <20111021173528.GA24406@sigill.intra.peff.net>
References: <20111021172239.GA22289@sigill.intra.peff.net>
 <20111021172804.GB24417@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 19:35:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHJ0e-0000Vv-8s
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 19:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222Ab1JURfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 13:35:32 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38981
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753282Ab1JURfb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 13:35:31 -0400
Received: (qmail 21894 invoked by uid 107); 21 Oct 2011 17:35:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Oct 2011 13:35:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Oct 2011 13:35:28 -0400
Content-Disposition: inline
In-Reply-To: <20111021172804.GB24417@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184074>

On Fri, Oct 21, 2011 at 01:28:04PM -0400, Jeff King wrote:

> Subject: [PATCH 2/3] contrib: add git-jump script
> [...]
> This fixes a minor bug in v1 where doing "git jump merge" would display
> the usage message when there were unmerged files, but none of the files
> contained conflict markers (i.e., you had already fixed them up).

Oops, the subject should read "PATCHv2", obviously.

-Peff
