From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] git-svnimport: Use separate arguments in the pipe for git-rev-parse
Date: Fri, 21 Sep 2007 12:24:20 +0200
Message-ID: <20070921102420.GJ11204@kiste.smurf.noris.de>
References: <200709161857.06065.danda@osc.co.cr> <7vlkb4wdzq.fsf@gitster.siamese.dyndns.org> <20070918092909.GU31176@kiste.smurf.noris.de> <200709201340.17023.danda@osc.co.cr> <20070921061122.GI11204@kiste.smurf.noris.de> <7vabrgjyg3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Libby <danda@osc.co.cr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 12:25:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYfhG-0000wc-2h
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 12:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007AbXIUKZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 06:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754042AbXIUKZM
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 06:25:12 -0400
Received: from smurf.noris.de ([192.109.102.42]:41133 "EHLO smurf.noris.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753596AbXIUKZL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 06:25:11 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35])
	by smurf.noris.de with smtp (Exim 4.63)
	(envelope-from <smurf@smurf.noris.de>)
	id 1IYfgO-0003JW-VK; Fri, 21 Sep 2007 12:24:25 +0200
Received: (nullmailer pid 17176 invoked by uid 501);
	Fri, 21 Sep 2007 10:24:20 -0000
Content-Disposition: inline
In-Reply-To: <7vabrgjyg3.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58839>

Hi,

Junio C Hamano:
> Matthias Urlichs <smurf@smurf.noris.de> writes:
> 
> >> we do not like 'Cristian new code' as a tag name.
> >
> > Duh? That's a perfectly valid tag name.
> 
> Is it?
> 
> $ man git-check-ref-format

Bah, stupid me. You're right, obviously.

I'll replace them with underscores. :-/

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Murphy's Law:
If anything can go wrong, it will.
