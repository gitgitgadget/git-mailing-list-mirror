From: layer <layer@known.net>
Subject: Re: missing tags!
Date: Wed, 08 Dec 2010 16:05:29 -0800
Message-ID: <12897.1291853129@relay.known.net>
References: <7986.1291837475@relay.known.net> <20101208201829.GA15938@sigill.intra.peff.net>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 09 01:05:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQU0u-00037E-PT
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 01:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898Ab0LIAFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 19:05:30 -0500
Received: from relay.known.net ([173.13.135.57]:45657 "EHLO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986Ab0LIAF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 19:05:29 -0500
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.21) id 000000146840; Wed, 8 Dec 2010 16:05:29 -0800
In-reply-to: <20101208201829.GA15938@sigill.intra.peff.net>
Comments: In-reply-to Jeff King <peff@peff.net>
   message dated "Wed, 08 Dec 2010 15:18:30 -0500."
X-Mailer: MH-E 8.2; nmh 1.3; GNU Emacs 23.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163245>

Jeff King <peff@peff.net> wrote:

>> On Wed, Dec 08, 2010 at 11:44:35AM -0800, layer wrote:
>> 
>> > I have a repo to which I push to frequently.  For each release of the
>> > software from this repo, I create an annotated tag and push it to this
>> > repo.  I noticed yesterday that he has a single tag in it, when it
>> > should have 100+.  The tag there was the last one I pushed to it.
>> > 
>> > The missing tags were created with
>> > 
>> >   git tag -a -m "release 4.2rm t1" release42rm_t1 HEAD
>> > 
>> > and pushed to the (bare) repo in question with
>> > 
>> >   git push origin release42rm_t1
>> > 
>> > I cannot imagine how the tags got deleted, and I'm looking for some
>> > guidance.
>> 
>> How did you verify that the tags were deleted? Are you sure they are not
>> just packed?

Ack.  I didn't know about packed tags.

Thanks, and sorry for the noise.

Kevin
