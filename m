From: Jeff King <peff@peff.net>
Subject: Re: Helping on Git development
Date: Wed, 14 Sep 2011 19:14:27 -0400
Message-ID: <20110914231427.GA5611@sigill.intra.peff.net>
References: <CAOz-D1JW8RSR8kVWhT7v-DCbWayU8KhbePJwWrWvJwbmueRezQ@mail.gmail.com>
 <CAOz-D1+77JZRXa57GLz=vZyrcGs4Ojj6Wa0cSD4QcEkMP3PPsA@mail.gmail.com>
 <CAH5451me+MDe34Boak=UDjH9T_WAnO6wxa6pW+JHOoGADoNfkQ@mail.gmail.com>
 <7vehzjugdz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Eduardo D'Avila <erdavila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 01:14:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3yfD-0006fW-Lo
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 01:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147Ab1INXO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 19:14:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57444
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945Ab1INXO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 19:14:28 -0400
Received: (qmail 15341 invoked by uid 107); 14 Sep 2011 23:15:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Sep 2011 19:15:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2011 19:14:27 -0400
Content-Disposition: inline
In-Reply-To: <7vehzjugdz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181408>

On Wed, Sep 14, 2011 at 11:29:28AM -0700, Junio C Hamano wrote:

> As to contributing to the project, right now, I think we have enough
> people who want to write code and documentation for Git, but what we lack
> are bandwidth to (this is not meant to be an exhaustive list):

Is there such a thing as enough coders? :)

Two things that got me started on git, and that I think are still
relevant today:

  1. Scratch your own itch. Surely git doesn't do something that you
     wish it did. Or did it faster. Or whatever. Try to dig up past
     discussions on the list to make sure you're not doing something
     that has already been tried and rejected, and then start hacking.
     Your patches may be terrible at first, but I think there are people
     willing to guide you if you actually have running code.

  2. Read the list. People will report bugs. Try reproducing them,
     bisecting them, creating minimal test cases, narrowing the issues
     down to certain configurations or a certain bit of code, etc.
     Sometimes that will lead you to propose a solution. Sometimes
     you'll just add to the discussion, and then somebody with more
     familiarity can pick up the topic from there. But you'll have
     helped them by doing some of the work, and you'll have learned more
     about how git works.

-Peff
