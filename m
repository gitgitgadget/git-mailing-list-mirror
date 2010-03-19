From: david@lang.hm
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 09:05:46 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1003190903540.3821@asgard.lang.hm>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>  <4BA338C1.7030803@alum.mit.edu>  <b4087cc51003190439x3c9ff269g35d11432bd2a3d60@mail.gmail.com>  <alpine.DEB.2.00.1003190441530.3821@asgard.lang.hm>  <20100319115445.GA12986@glandium.org> 
 <3f4fd2641003190509j6e4908e4kab87b601d2ce9c00@mail.gmail.com>  <b4087cc51003190516h42202e34k598a163c246cb9f2@mail.gmail.com> <3f4fd2641003190757y39050691y3dc0ca08bd5196fb@mail.gmail.com> <4BA397B0.2000908@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Reece Dunn <msclrhd@googlemail.com>,
	Michael Witten <mfwitten@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 19 17:06:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NseiP-00057Q-CQ
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 17:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168Ab0CSQGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 12:06:20 -0400
Received: from mail.lang.hm ([64.81.33.126]:41245 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323Ab0CSQGU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 12:06:20 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id o2JG5kEJ019896;
	Fri, 19 Mar 2010 08:05:46 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <4BA397B0.2000908@drmicha.warpmail.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142616>

On Fri, 19 Mar 2010, Michael J Gruber wrote:

> Reece Dunn venit, vidit, dixit 19.03.2010 15:57:
>
> [snip]
>>
>> So, I'll ask again: what problems are you trying to solve that
>> cannot be solved by mailmap?
>>
>> - Reece
>
> [Attention, conspiracy theories below!]
>
> The problem seems to be that some people are interested in statistics,
> so some are interested in consistent author information, but this
> requires others (the authors) to maintain this information, at least on
> large projects where this information cannot be kept consistent by a few
> people. So, some people are looking for a way to enforce this on the
> others... Of course, one could also rephrase this is as "help authors
> maintain their authorship information in a consistent way" ;)

but a UUID doesn't help you.

if you can force people to have a consistant UUID, you can force them to 
have a consistant e-mail address (and submit mapping updates if it 
changes)

if you can't force people to maintain a consistant e-mail, why do you 
think they would maintain a consistant UUID?

David Lang
