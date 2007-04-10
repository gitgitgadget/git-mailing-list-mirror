From: alan <alan@clueserver.org>
Subject: Re: [OT] Re: Feature request - Subtree checkouts
Date: Tue, 10 Apr 2007 15:30:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704101513480.17260@blackbox.fnordora.org>
References: <20070410074444.GA18541@curie-int.orbis-terrarum.net>
 <20070410132011.GH5436@spearce.org> <7vslb8ug7y.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0704101338060.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704101414330.15823@blackbox.fnordora.org>
 <Pine.LNX.4.64.0704101501590.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 07:45:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbOrb-0007em-Ey
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 00:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030588AbXDJWaV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 18:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030591AbXDJWaU
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 18:30:20 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:56382 "EHLO
	clueserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030588AbXDJWaS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 18:30:18 -0400
Received: by clueserver.org (Postfix, from userid 500)
	id CB0ACE78002; Tue, 10 Apr 2007 15:30:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id C64C1F505CC;
	Tue, 10 Apr 2007 15:30:16 -0700 (PDT)
X-X-Sender: alan@blackbox.fnordora.org
In-Reply-To: <Pine.LNX.4.64.0704101501590.6730@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44186>

On Tue, 10 Apr 2007, Linus Torvalds wrote:

>
>
> On Tue, 10 Apr 2007, alan wrote:
>>>
>>> For example, I will personally never see email that comes directly to my
>>> email address though an open mail relay *or* from something that appears
>>> to be just a random botnet PC (I forget the exact rule, since I'm hapily
>>> ignorant of MIS, but I think it boils down to requiring a good reverse DNS
>>> lookup).
>>
>> Depending on your definition of "good".
>
> Well, the most common case (and the thing I *think* our spam software does
> here) is to just confirm that the reverse DNS lookup (that you want to do
> *anyway* for the "Received" headers for the email) will resolve back to
> the same IP (aka "FCrDNS").
>
> It's also possible to just not accept mail if the reverse lookup indicates
> that the sending IP address is a dynamic address, which you can sometimes
> see from the hostname. I would suggest you *not* name your hosts to
> contain a lot of numbers and the string "dhcp", for example ;)

I actually have a fixed IP address.

>> Sometimes I think the anti-spam methods are as obnoxious as the
>> spammers. Almost.)
>
> I'll take strict anti-spam methods any day. I get about 10 pieces of spam
> a day, that I can handle easily without worrying about it. I shudder to
> even just think about what it used to be like before aggressive spam
> filtering.

Greylisting dropped my spam level by at least 90%.  RBLs have, for the 
most part, had far too many false positives to be useful.  (If it was just 
me, it would not be so bad, but my wife gets mail on this server as well. 
She is not so forgiving.)

> So I'm personally *solidly* in the camp that says "if you want to send me
> email, it's worth making a conscious effort to not look like spam".

I try pretty hard. However, some anti-spam methods share some of the same 
methods with dowsing and other witchcraft. What "looks like spam" seems 
pretty subjective at times.

I do have a reason for being a bit negative about it.  I once ran a very 
large development list back in the last century.  A piece of spam got past 
my spam filters and onto the list.  Some idiot got offended and reported 
me as a spammer (because my ip was the first thing he saw) and reported me 
to my isp and to my isp's upstream feed.  Took me a couple days to get 
everyone calmed down.  Excessive anti-spammers still get on my nerves 
after that incident.

-- 
"Invoking the supernatural can explain anything, and hence explains nothing."
                   - University of Utah bioengineering professor Gregory Clark
