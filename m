From: "Chris Lee" <clee@kde.org>
Subject: Re: More precise tag following
Date: Mon, 29 Jan 2007 11:16:43 -0800
Message-ID: <204011cb0701291116r4169a0d9gf8837957c3f028d4@mail.gmail.com>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
	 <20070127080126.GC9966@spearce.org>
	 <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
	 <45BB9C8B.8020907@fs.ei.tum.de>
	 <Pine.LNX.4.64.0701271103520.25027@woody.linux-foundation.org>
	 <204011cb0701271136m655815f6o1501de2bf699b362@mail.gmail.com>
	 <Pine.LNX.4.63.0701281425270.26863@qynat.qvtvafvgr.pbz>
	 <Pine.LNX.4.64.0701291224100.3021@xanadu.home>
	 <Pine.LNX.4.64.0701290940520.3611@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0701291246090.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"David Lang" <david.lang@digitalinsight.com>,
	"Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jan 29 20:17:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBbzv-0006iB-QB
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 20:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbXA2TQq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 14:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbXA2TQq
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 14:16:46 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:31802 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbXA2TQp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 14:16:45 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1868744wxd
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 11:16:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=cWVqRhLwv3emQef4NX+KSgZdyj1Z9QRX0P8AaWmsGQj5lW2B1QMMZPEhYw/tzaS32Eg+WXkLESkiXbEuQWNHOcLLBZc53Hpl2vsrWq09l1E0hQ2dADDLO7sWAiE0PR2VZKRdQhwwY8mLnHRW/4fHgPv4aPtEgMEn1mBfbldYYDM=
Received: by 10.90.75.10 with SMTP id x10mr7198205aga.1170098204318;
        Mon, 29 Jan 2007 11:16:44 -0800 (PST)
Received: by 10.90.81.16 with HTTP; Mon, 29 Jan 2007 11:16:43 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0701291246090.3021@xanadu.home>
Content-Disposition: inline
X-Google-Sender-Auth: cfaa4612eeabd762
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38091>

On 1/29/07, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 29 Jan 2007, Linus Torvalds wrote:
> > Well, it doesn't really help Chris. All the data will end up starting from
> > him anyway.
>
> Sure, but I was under the impression this wasn't the problem.  Given
> what Chris said:
>
> |I don't have access to any servers that I could drop a 3GB packfile
> |onto and expect them to serve it. [...] If anybody wants to hook me up
> |with a hosting provider or a machine that just the git devs can access,
> |I'd be willing to tie up my upstream bandwidth for a few days so you
> |all can have access to it.
>
> And then David said:
>
> |if nobody else steps forward I can arrange something like this on my
> |home server (only 768K updtream bandwidth, but it's better then
> |nothing)
>
> So it looks like the server was the main issue here.
>
> > Once it's uploaded anywhere, we've got people willing to mirror it
> > infinitely ..
>
> Has this been set up with Chris already?

I'm going to burn a DVD with the repo on it later today and mail it to
hpa since he's only like two towns over.

So, hopefully, it'll be up somewhere useful by the end of the week :)
