From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Update SubmittingPatches
Date: Wed, 2 Jan 2013 04:08:03 -0500
Message-ID: <20130102090803.GC9328@sigill.intra.peff.net>
References: <1357082695-29713-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jason Holden <jason.k.holden.swdev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 10:08:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqKJX-0001SM-GN
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 10:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274Ab3ABJII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 04:08:08 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41247 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361Ab3ABJIH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 04:08:07 -0500
Received: (qmail 28621 invoked by uid 107); 2 Jan 2013 09:09:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Jan 2013 04:09:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Jan 2013 04:08:03 -0500
Content-Disposition: inline
In-Reply-To: <1357082695-29713-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212509>

On Tue, Jan 01, 2013 at 03:24:52PM -0800, Junio C Hamano wrote:

> The main thing this series wants to do is the second one, but I
> wanted to reduce the clutter in this document while at it.
> 
> Junio C Hamano (3):
>   SubmittingPatches: who am I and who cares?
>   SubmittingPatches: mention subsystems with dedicated repositories
>   SubmittingPatches: remove overlong checklist

FWIW, all look reasonable to me. I did not pay close attention to the
earlier discussion on MAINTAINERS, but my first thought on reading it
was "why isn't this stuff just in the SubmittingPatches doc? That's
where I would look for it".

I guess some people might balk at the third one, as the checklist is
supposed to help with a quick and easy start. But I agree with your
commit log message that it isn't short or quick anymore. Of course it
has been a long time since I have needed to read that document. Maybe
people who have used it more recently would have more relevant thoughts.

-Peff
