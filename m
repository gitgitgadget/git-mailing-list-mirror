From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] mergetool merge/skip/abort
Date: Tue, 27 Jan 2009 22:09:47 +0000
Message-ID: <20090127220947.GA21319@hashpling.org>
References: <81bfc67a0901210637j52fa7a55q51b599e9ff16f6dc@mail.gmail.com> <20090121170434.GA21727@hashpling.org> <81bfc67a0901220617l22b5a8e4ma48bb069d67cae91@mail.gmail.com> <20090122142258.GA2316@hashpling.org> <81bfc67a0901230716i166bfc4chd9a5c0990b0cd3b6@mail.gmail.com> <7vwscmue5z.fsf@gitster.siamese.dyndns.org> <20090126225835.GB10118@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 23:11:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRw9O-0003ER-MZ
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 23:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbZA0WJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 17:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbZA0WJv
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 17:09:51 -0500
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:7596 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752316AbZA0WJu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jan 2009 17:09:50 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAAcVf0nUnw6U/2dsb2JhbADLAIVHBg
Received: from fhw-relay07.plus.net ([212.159.14.148])
  by relay.pcl-ipout02.plus.net with ESMTP; 27 Jan 2009 22:09:48 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by fhw-relay07.plus.net with esmtp (Exim) id 1LRw7w-0004HS-Rq; Tue, 27 Jan 2009 22:09:49 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n0RM9lFU021929
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 27 Jan 2009 22:09:48 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n0RM9lNr021928;
	Tue, 27 Jan 2009 22:09:47 GMT
Content-Disposition: inline
In-Reply-To: <20090126225835.GB10118@mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 0100f599dd094346b9ed2990db1a4fcc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107395>

On Mon, Jan 26, 2009 at 05:58:35PM -0500, Theodore Tso wrote:
> I was the original author of mergetool, and for a while I was the
> person that was reviewing and managing the mergetool patches for
> Junio.  Unfortunately, in the last couple of months I just haven't had
> the time keep up with the various mergetool proposed patch updates.
> 
> So maybe it's time for me to hand it off to someone who has the time
> and interest in continuing to hack mergetool, and has the necessary
> "good taste" and such that Junio would be willing to trust that person
> to be the git mergetool patch wrangler?
> 
> 							- Ted

A quick blame session has shown that after Ted I've probably touched
the next most number of lines of mergetool. It's a crude measure and
not necessarily a sign of competence, I admit.

Although not rolling in spare time, I feel I'd be able review
mergetool patches at roughly the rate that they tend to appear at the
moment.

Given the above, if I pass the "good taste" and "Junio trust" tests I
feel that I should offer my services as mergetool patch wrangler.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
