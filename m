From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: Re: [PATCH 3/3] add '%d' pretty format specifier to show
 decoration
Date: Tue, 9 Sep 2008 19:33:33 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0809091932080.3862@pollux>
References: <alpine.LNX.1.10.0809032036270.32295@pollux> <20080903191217.GA31195@coredump.intra.peff.net> <7v4p4xat3v.fsf@gitster.siamese.dyndns.org> <20080903203616.GB32223@coredump.intra.peff.net> <7vsksh9c9m.fsf@gitster.siamese.dyndns.org>
 <48BF0A5A.2040502@lsrfire.ath.cx> <20080904035139.GA28123@sigill.intra.peff.net> <48C002FB.9010401@lsrfire.ath.cx> <48C055B3.3030204@lsrfire.ath.cx> <20080905001133.GA17463@coredump.intra.peff.net> <7v7i9r1lnm.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.10.0809052035280.3868@pollux>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-751586682-1220981081=:3862"
Cc: Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 09 19:35:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd77Y-0007SR-5r
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 19:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbYIIReN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 13:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753575AbYIIReN
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 13:34:13 -0400
Received: from mailout02.t-online.de ([194.25.134.17]:35501 "EHLO
	mailout02.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbYIIReM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 13:34:12 -0400
Received: from fwd29.aul.t-online.de 
	by mailout02.sul.t-online.de with smtp 
	id 1Kd75r-0003TE-02; Tue, 09 Sep 2008 19:33:35 +0200
Received: from [192.168.2.100] (SP753QZZZhezXedgHJmYwzbzWEHeXQzGFzdULNhT86DCrvvG8TklsMTrqH3jzc+wXb@[84.163.237.7]) by fwd29.t-online.de
	with esmtp id 1Kd75e-1UWxM00; Tue, 9 Sep 2008 19:33:22 +0200
X-X-Sender: michael@pollux
In-Reply-To: <alpine.LNX.1.10.0809052035280.3868@pollux>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Content-ID: <alpine.LNX.2.00.0809091924570.3862@pollux>
X-ID: SP753QZZZhezXedgHJmYwzbzWEHeXQzGFzdULNhT86DCrvvG8TklsMTrqH3jzc+wXb
X-TOI-MSGID: 0726d5ed-7355-4920-867e-a25496e12e2f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95408>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-751586682-1220981081=:3862
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.2.00.0809091924571.3862@pollux>

On Fri, 5 Sep 2008, Michael Dressel wrote:

>
>
> On Thu, 4 Sep 2008, Junio C Hamano wrote:
>
>>  Jeff King <peff@peff.net> writes:
>> 
>> >  On Thu, Sep 04, 2008 at 11:40:03PM +0200, René Scharfe wrote:
>> > 
>> > >  Michael Dressel implemented an initial version and chose the letter d,
>> > >  Junio suggested to add a leading space and parentheses.
>> > 
>
> Very nice.
> Only that I did not do the very first implementation it was Jeff King.

I made a mistake. My last comment is wrong, There is an even  earlier 
patch from Johannes Schindelin. Second there is no contribution  left from 
me. I'm merely a happy user of the new feature.

Cheers,
Michael


--0-751586682-1220981081=:3862--
