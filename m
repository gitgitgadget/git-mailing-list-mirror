From: david@lang.hm
Subject: Re: Is incremental staging really the common mode?
Date: Sun, 7 Sep 2008 17:45:24 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0809071742470.8096@asgard.lang.hm>
References: <51419b2c0809071317g6f916b19p1c2792595be58047@mail.gmail.com> <alpine.DEB.1.10.0809071729310.8096@asgard.lang.hm> <7v1vzvjwqz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Elijah Newren <newren@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 02:45:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcUst-0001oQ-Vh
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 02:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbYIHAoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 20:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbYIHAod
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 20:44:33 -0400
Received: from mail.lang.hm ([64.81.33.126]:37187 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885AbYIHAod (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 20:44:33 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m880iRqp028546;
	Sun, 7 Sep 2008 17:44:27 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <7v1vzvjwqz.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95203>

On Sun, 7 Sep 2008, Junio C Hamano wrote:

> david@lang.hm writes:
>
>> also, how many are doing 'git add .' or 'git add *' followed by git
>> commit?
>
> Everybody who starts a new history from scratch from an existing tarball
> would be doing this at least once ;-)
>
>> there were several commands listed that I have never heard of before
>> and will want to research to see what they do to see if I should be
>> using them.
>
> The commands singled out were either (1) ancient, nobody should be using
> them, and we would love to prove that nobody is using them anymore so that
> we can remove them, or (2) reasonably new inventions that would help
> common situations more than the stock Porcelain we have had for years, to
> see if they are already widely adopted.

it would be really good to indicate which is which. I spotted several 
things that looked like they would help me, but I have no idea which ones 
I should use and which I shouldn't

> Perhaps somebody (or group of people, taking turns) should post a "git
> trick of the week" series to this mailing list?

that would be a good idea. I would suggest also putting them on the wiki 
and (if possible) package them up periodicly as a fortune file.

David Lang
