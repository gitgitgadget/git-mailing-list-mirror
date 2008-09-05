From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: Re: [PATCH 3/3] add '%d' pretty format specifier to show
 decoration
Date: Fri, 5 Sep 2008 20:38:03 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0809052035280.3868@pollux>
References: <alpine.LNX.1.10.0809032036270.32295@pollux> <20080903191217.GA31195@coredump.intra.peff.net> <7v4p4xat3v.fsf@gitster.siamese.dyndns.org> <20080903203616.GB32223@coredump.intra.peff.net> <7vsksh9c9m.fsf@gitster.siamese.dyndns.org>
 <48BF0A5A.2040502@lsrfire.ath.cx> <20080904035139.GA28123@sigill.intra.peff.net> <48C002FB.9010401@lsrfire.ath.cx> <48C055B3.3030204@lsrfire.ath.cx> <20080905001133.GA17463@coredump.intra.peff.net> <7v7i9r1lnm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-2037727355-1220639779=:3868"
Cc: Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 20:40:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbgDV-0002UX-UL
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 20:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbYIESi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 14:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbYIESi2
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 14:38:28 -0400
Received: from mailout07.t-online.de ([194.25.134.83]:50018 "EHLO
	mailout07.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbYIESi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 14:38:27 -0400
Received: from fwd24.aul.t-online.de 
	by mailout07.sul.t-online.de with smtp 
	id 1KbgC2-0007MI-00; Fri, 05 Sep 2008 20:38:02 +0200
Received: from [192.168.2.100] (r28N1ZZZwh1+3OQaImMKoCtkVYjykLDaWqPoIXq0iQPlIFbLmzhK0YgUOt8fkBjQ4S@[84.163.207.35]) by fwd24.t-online.de
	with esmtp id 1KbgBw-0QA7VI0; Fri, 5 Sep 2008 20:37:56 +0200
X-X-Sender: michael@pollux
In-Reply-To: <7v7i9r1lnm.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Content-ID: <alpine.LNX.1.10.0809052036550.3868@pollux>
X-ID: r28N1ZZZwh1+3OQaImMKoCtkVYjykLDaWqPoIXq0iQPlIFbLmzhK0YgUOt8fkBjQ4S
X-TOI-MSGID: 344d2e5e-7172-4777-9593-9cf62991473a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95029>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-2037727355-1220639779=:3868
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.1.10.0809052036551.3868@pollux>



On Thu, 4 Sep 2008, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> On Thu, Sep 04, 2008 at 11:40:03PM +0200, René Scharfe wrote:
>>
>>> Michael Dressel implemented an initial version and chose the letter d,
>>> Junio suggested to add a leading space and parentheses.
>>

Very nice.
Only that I did not do the very first implementation it was Jeff King.

Cheers,
Michael
--0-2037727355-1220639779=:3868--
