From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: How to resume broke clone ?
Date: Thu, 05 Dec 2013 14:21:09 +0100
Message-ID: <52A07DC5.5090508@alum.mit.edu>
References: <AAA12788-A242-41B8-B47D-1A0A52F33FC1@ancientrocklab.com> <5296F343.6050506@gmail.com> <560807D9-CE82-4CF6-A1CC-54E7CCA624F9@ancientrocklab.com> <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com> <5297004F.4090003@gmail.com> <CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com> <211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com> <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com> <20131128092935.GC11444@sigill.intra.peff.net> <CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com> <20131204200850.GB16603@sigill.intra.peff.net> <CAJo=hJuRz9Qc8ztQATkEs8huDfiANMA6gZEOapoofVdoY82k4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	zhifeng hu <zf@ancientrocklab.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdQ==?= =?UTF-8?B?w6Ju?= 
	<vnwildman@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 05 14:28:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYyd-0005O1-7F
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 14:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301Ab3LEN2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 08:28:19 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:53086 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932230Ab3LEN2S (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Dec 2013 08:28:18 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Dec 2013 08:28:18 EST
X-AuditID: 1207440c-b7f566d000004272-cb-52a07dcb7479
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id B5.EF.17010.BCD70A25; Thu,  5 Dec 2013 08:21:15 -0500 (EST)
Received: from [192.168.69.148] (p57A25DD3.dip0.t-ipconnect.de [87.162.93.211])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rB5DLB2Y002854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 5 Dec 2013 08:21:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131005 Icedove/17.0.9
In-Reply-To: <CAJo=hJuRz9Qc8ztQATkEs8huDfiANMA6gZEOapoofVdoY82k4g@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsUixO6iqHu6dkGQQe80I4uuK91MFgv/HWW3
	6J7yltHiR0sPs8X8QxNZLc7O+8xkcfT/OkYHdo8XbRfZPXbOusvu8ax3D6PHn/N7WD0+b5IL
	YI3itklKLCkLzkzP07dL4M44sn0RW8FtwYrJxxezNDAu4eti5OCQEDCRuNYr28XICWSKSVy4
	t56ti5GLQ0jgMqNE94bzTBDOOSaJ43vPsINU8QpoSzzd/4cZxGYRUJVYeOkeC4jNJqArsain
	mQnEFhUIknh06CFUvaDEyZlPwGpEBNQktl/oYQUZyiywlEmio38rWEJYQENi56u17BDbVrFK
	zJ3/FaybUyBQ4kD3CxaIU8UlehqDQExmAXWJ9fOEQCqYBeQltr+dwzyBUXAWknWzEKpmIala
	wMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXUC83s0QvNaV0EyMkHnh2MH5bJ3OIUYCDUYmH
	90Xi/CAh1sSy4srcQ4ySHExKorzvKxcECfEl5adUZiQWZ8QXleakFh9ilOBgVhLhFc4ByvGm
	JFZWpRblw6SkOViUxHlVl6j7CQmkJ5akZqemFqQWwWRlODiUJHhv1AA1ChalpqdWpGXmlCCk
	mTg4QYZzSYkUp+alpBYllpZkxIPiN74YGMEgKR6gvUUg7bzFBYm5QFGI1lOMuhzzvnz4xijE
	kpeflyolzvsEpEgApCijNA9uBSz5vWIUB/pYmPcOSBUPMHHCTXoFtIQJaEnzg3kgS0oSEVJS
	DYx8jbbdL9+v+vizRHfx92ONDlc7t+6TWLZrMmv/tEkHTkw7umRp2dJ4/tMWlv9s 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238885>

This discussion has mostly been about letting small Git servers delegate
the work of an initial clone to a beefier server.  I haven't seen any
explicit mention of the inverse:

Suppose a company has a central Git server that is meant to be the
"single source of truth", but has worldwide offices and wants to locate
bootstrap mirrors in each office.  The end users would not even want to
know that there are multiple servers.  Hosters like GitHub might also
encourage their big customers to set up bootstrap mirror(s) in-house to
make cloning faster for their users while reducing internet traffic and
the burden on their own infrastructure.  The goal would be to make the
system transparent to users and easily reconfigurable as circumstances
change.

One alternative would be to ask users to clone from their local mirror.
 The local mirror would give them whatever it has, then do the
equivalent of a permanent redirect to tell the client "from now on, use
the central server" to get the rest of the initial clone and for future
fetches.  But this would require users to know which mirror is "local".

A better alternative would be to ask users to clone from the central
server.  In this case, the central server would want to tell the clients
to grab what they can from their local bootstrap mirror and then come
back to the central server for any remainders.  The trick is that which
bootstrap mirror is "local" would vary from client to client.

I suppose that this could be implemented using what you have discussed
by having the central server direct the client to a URL that resolves
differently for different clients, CDN-like.  Alternatively, the central
Git server could itself look where a request is coming from and use some
intelligence to redirect the client to the closest bootstrap mirror from
its own list.  Or the server could pass the client a list of known
mirrors, and the client could try to determine which one is closest (and
reachable!).

I'm not sure that this idea is interesting, but I just wanted to throw
it out there as a related use case that seems a bit different than what
you have been discussing.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
