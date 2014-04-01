From: Mike Hommey <mh@glandium.org>
Subject: Re: fast-import deltas
Date: Wed, 2 Apr 2014 08:12:35 +0900
Message-ID: <20140401231235.GA8422@glandium.org>
References: <20140401102554.GA32231@glandium.org>
 <20140401114502.GA15549@sigill.intra.peff.net>
 <20140401130703.GA1479@glandium.org>
 <20140401131512.GA19321@sigill.intra.peff.net>
 <20140401141856.GA2497@glandium.org>
 <xmqqk3b90y79.fsf@gitster.dls.corp.google.com>
 <20140401221003.GA5923@glandium.org>
 <xmqqlhvoy92m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 11:35:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVdkj-0004JW-Nw
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbaDAXM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 19:12:57 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:49276 "EHLO
	zenigata.glandium.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754396AbaDAXMt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 19:12:49 -0400
Received: from glandium by zenigata.glandium.org with local (Exim 4.82)
	(envelope-from <glandium@glandium.org>)
	id 1WV7r9-0002Dv-NI; Wed, 02 Apr 2014 08:12:35 +0900
Content-Disposition: inline
In-Reply-To: <xmqqlhvoy92m.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245671>

On Tue, Apr 01, 2014 at 03:32:49PM -0700, Junio C Hamano wrote:
> [Footnote]
> 
> *1* I am still not sure how useful the feature would be outside
> slurping from Hg and Git---for obvious reasons, though.  As long as
> the change is to a cleanly isolated codepath, it would be OK, I
> guess.

That's why I started the thread by asking if there would be some
interest for this feature. I'm not even sure it would be entirely
beneficial to my usecase, just a hunch.

Mike
