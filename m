From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/3] add '%d' pretty format specifier to show decoration
Date: Tue, 09 Sep 2008 22:15:40 +0200
Message-ID: <48C6D96C.3020207@lsrfire.ath.cx>
References: <alpine.LNX.1.10.0809032036270.32295@pollux> <20080903191217.GA31195@coredump.intra.peff.net> <7v4p4xat3v.fsf@gitster.siamese.dyndns.org> <20080903203616.GB32223@coredump.intra.peff.net> <7vsksh9c9m.fsf@gitster.siamese.dyndns.org> <48BF0A5A.2040502@lsrfire.ath.cx> <20080904035139.GA28123@sigill.intra.peff.net> <48C002FB.9010401@lsrfire.ath.cx> <48C055B3.3030204@lsrfire.ath.cx> <20080905001133.GA17463@coredump.intra.peff.net> <7v7i9r1lnm.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0809052035280.3868@pollux> <alpine.LNX.2.00.0809091932080.3862@pollux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Jeff King <peff@peff.net>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Tue Sep 09 22:17:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd9e3-0001R0-Dw
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 22:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177AbYIIUPw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Sep 2008 16:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754762AbYIIUPw
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 16:15:52 -0400
Received: from india601.server4you.de ([85.25.151.105]:48975 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181AbYIIUPw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 16:15:52 -0400
Received: from [10.0.1.200] (p57B7CA89.dip.t-dialin.net [87.183.202.137])
	by india601.server4you.de (Postfix) with ESMTPSA id A85062F8043;
	Tue,  9 Sep 2008 22:15:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <alpine.LNX.2.00.0809091932080.3862@pollux>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95421>

Michael Dressel schrieb:
> On Fri, 5 Sep 2008, Michael Dressel wrote:
>> On Thu, 4 Sep 2008, Junio C Hamano wrote:
>>> Jeff King <peff@peff.net> writes:
>>>> On Thu, Sep 04, 2008 at 11:40:03PM +0200, Ren=E9 Scharfe wrote:
>>>>> Michael Dressel implemented an initial version and chose the=20
>>>>> letter d, Junio suggested to add a leading space and=20
>>>>> parentheses.
>>=20
>> Very nice. Only that I did not do the very first implementation it=20
>> was Jeff King.
>=20
> I made a mistake. My last comment is wrong, There is an even  earlier
> patch from Johannes Schindelin. Second there is no contribution left
> from me. I'm merely a happy user of the new feature.

Hmm, when I wrote this commit message I didn't reread yours that
mentioned Jeff.  The patch is already in next; I'm not sure if changing
its commit message is a sensible option.  I remember that Dscho
suggested multiple times to steal his ideas, implement them and then
reap all the credit for them, though. ;-)

Ren=E9
