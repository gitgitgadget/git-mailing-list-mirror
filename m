From: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
Subject: Re: [PATCH] Documentation: add a new man page for "git-help" and
 -i|--info option.
Date: Wed, 05 Dec 2007 10:33:52 +0200
Message-ID: <E6D70DFA-79C6-4B97-B749-DEE11F2B2B47@pp.inet.fi>
References: <20071204064429.1b5007b2.chriscool@tuxfamily.org>
 <178B37CE-9B28-4CE2-B8A0-FCA28CF85E12@pp.inet.fi>
 <B4734D40-9EE8-4B96-9426-FF5974F8488E@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 09:34:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzpiY-00076D-Cg
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 09:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbXLEIed convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 03:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbXLEIed
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 03:34:33 -0500
Received: from astana.suomi.net ([82.128.152.18]:48560 "EHLO astana.suomi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbXLEIec convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Dec 2007 03:34:32 -0500
Received: from taku.suomi.net ([82.128.154.66])
 by astana.suomi.net (Sun Java System Messaging Server 6.2-3.04 (built Jul 15
 2005)) with ESMTP id <0JSK003FHICNRJ50@astana.suomi.net> for
 git@vger.kernel.org; Wed, 05 Dec 2007 10:31:35 +0200 (EET)
Received: from spam5.suomi.net (spam5.suomi.net [212.50.131.165])
 by mailstore.suomi.net
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSK00AY3IGTTS00@mailstore.suomi.net> for git@vger.kernel.org;
 Wed, 05 Dec 2007 10:34:05 +0200 (EET)
Received: from Kaalimaa.fudeco.com (unknown [213.139.166.27])
	by spam5.suomi.net (Postfix) with ESMTP id 87CCB2FE05; Wed,
 05 Dec 2007 08:33:52 +0000 (UTC)
In-reply-to: <B4734D40-9EE8-4B96-9426-FF5974F8488E@wincent.com>
X-Mailer: Apple Mail (2.915)
X-OPOY-MailScanner-Watermark: 1197448433.09198@6BU2/qtQWvQjZNi4Fi6q1g
X-OPOY-MailScanner-Information: Please contact OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (not cached, score=0.1,
	required 5, RDNS_NONE 0.10)
X-OPOY-MailScanner-From: v@pp.inet.fi
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67124>


On Dec 5, 2007, at 10:27, Wincent Colaiuta wrote:

> El 5/12/2007, a las 9:19, V=E4in=F6 J=E4rvel=E4 escribi=F3:
>
>> Patch attached to fix header error in this patch.
>>
>> (Attached because Mail.app mangles inline patches)
>
> I'm a Mail.app user as well. Any reason why you can't use "git send-=20
> email"? It's very useful.

I didn't remember that send-email had "--in-reply-to" parameter, and I =
=20
thought it would be cleaner to send as a reply. Thus I used Mail.app.

--
V=E4in=F6
