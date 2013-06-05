From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Wed, 05 Jun 2013 06:13:35 +0200
Message-ID: <51AEBAEF.6090402@alum.mit.edu>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 06:13:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk56g-0005KP-Nh
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 06:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200Ab3FEENq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 00:13:46 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:63029 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751115Ab3FEENo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jun 2013 00:13:44 -0400
X-AuditID: 1207440d-b7fd06d000000905-a0-51aebaf7ccee
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 6B.1D.02309.7FABEA15; Wed,  5 Jun 2013 00:13:43 -0400 (EDT)
Received: from [192.168.69.140] (p57A24E5B.dip0.t-ipconnect.de [87.162.78.91])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r554Daq6011857
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 5 Jun 2013 00:13:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7va9n52zjc.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURzGObvb9fpy43jVdrJSWqWlzDIiLiVR0Yf7QSKTBPuQXd1pG253
	sruJ2odGb9Bsmb1RQy3KCqS0NMpNk1rQu+XL0sLMRFulzooSjT7YvTOzb885z+//PBz+hyKY
	oCqeMgo2bBV4k4aMUDJhW5doJ731Waur76jZB0MC6/SXK1iHy0+ww9X9BFtxzUmywbe1gL3+
	5STJdv1oULHlp4OAnTp0jGBbzl4k2ZFzPQq2v7subBPNedz9Ydy377u5yp+PVVzf6AWCGxxx
	hnG9bwIkF3C1Aq6zayk3VPlExf1oTNgesSsyI5+3FWcb9cKqjXsiDc9d98iiy4tLHL2sAzSr
	nSCcQnAtqhr1K2b0fNTxvoF0ggiKgd0ANXR4lTOHdgWq8D5UyRQNU9EjdxOQtRIuR22BvtA0
	CbXo0rGDIR0Hc9DXq2f+8tHo6flhpaxjYRKqPOILhRLwkRL1+D6HgmJgOpo44QlBDMxD/rOd
	UhBFhcN16GNngSwJmIwaahiZIGAiuhusIk4A6P6vwT1Huf+jLgKiDiTwJrtZa+aNJhEXaMUC
	XhCwVbsmzWy0pWGdvRHMrItuBtP1i3wAUkATRbMTN7IYFV8slpp9YAGl0MTRVZ76LGZevkVX
	auBFQ57VbsKiDyCK0MTSO/dIHq3jS8uw1TJrLaSUGjWdVJu8jYF63oYLMS7C1ll3EUVpEO2R
	Q6OtWI9L9hpNtjlbQYXL4RHxsSIWdNjK222GPHmleaK0U9mKknp18jgtFvFm6XZm9BnQUuem
	To0DRilYBByvpl0yBGXIYBf+Vcz+0hGgll4cQ9+SqSjpD/9LGpFKFFLJqdE6ucTG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226428>

On 06/05/2013 02:04 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> * fc/contrib-related (2013-06-03) 4 commits
>>  - contrib: related: parse committish like format-patch
>>  - contrib: related: add option to parse from committish
>>  - contrib: related: add support for multiple patches
>>  - Add new git-related helper to contrib
>>
>>  Waiting for the design review to settle.
> 
> As people may have seen in the discussion on the earlier iteration,
> something like this (there may be a room for bikeshedding the name,
> though) that takes either a range of changes or set of patches and
> finds people who may be able to review them may be a good addition
> to our official toolchest.
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/221728/focus=221796
> 
> Right now, "related" is in contrib/ primarily because its design
> review phase is not yet finished and because it is in Ruby, which
> the rest of the system does not depend on.
> 
> I have some administrative comments on two issues as the maintainer.
> 
>  * Do we want to add Ruby dependency?
>  * Do we want to keep expanding contrib/?
> 
> These have been triggered by "related", but the comments in this
> message are not limited to the specific topic (e.g. you can read it
> with s/Ruby/<any language we currently do not depend on>/).
> 
> 
> On Ruby:
> [...]

I don't have an opinion on allowing Ruby into the core, except to say
that I would personally prefer *some* alternative that is more capable
than shell and more modern and self-consistent than Perl.  Python, Ruby,
and Lua would seem to be the obvious candidates, with the latter being
easiest for packagers.

> On contrib/:
> 
> Back when Git was very young, it made sense to bundle third-party
> tools in our tree's "contrib/" section to give them visibility and
> users convenience.  Now Git ecosystem has grown to have many users
> who know Git and who do not necessarily come to this list, and with
> easy-to-use hosting sites where anybody can publish their ware and
> collaborate with their contributors, "giving more visibility" angle
> of contrib/ has outlived its usefulness.  When there are multiple
> third-party tools that address similar needs, there is not much
> point picking one at random and ship it over others, and shipping
> all of them is simply crazy.  In an ecosystem with flourishing
> third-party add-ons, their products should and will stand on their
> own.

For completeness, let me point out two other small advantages of contrib:

* a tool in contrib can assume that it is being bundled with the
corresponding version of Git, and therefore doesn't necessarily have to
go to the effort of supporting older versions of Git.

* at the source-code level, a tool in contrib can take advantage of some
of the Git build/test infrastructure, though I don't know whether they
currently do.


But my main point is that I think it would be easier to phase out
contrib/ if there were a good alternate way of providing visibility to
"satellite" projects.  The relevant Git wiki page [1] is the most likely
candidate, but it is a bit overwhelming due to its size, it has fallen
into disuse because it was broken for such a long time, and it is not
prominently linked to from git-scm.com.  If it were curated a bit, it
would help users find the best ancillary tools quickly.  Perhaps ranking
the tools based on the results of the Git user surveys would help bring
the most popular to the top of each category.

Michael

[1] https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
