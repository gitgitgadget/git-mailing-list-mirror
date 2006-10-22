From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 07:44:22 -0400
Message-ID: <20061022074422.50dcbee6.seanlkml__21103.2852800146$1161517652$gmane$org@sympatico.ca>
References: <45382120.9060702@utoronto.ca> <87irie1wvv.wl%cworth@cworth.org>
	<20061021130111.GL75501@over-yonder.net>
	<87ac3p1jn7.wl%cworth@cworth.org>
	<1161472030.9241.174.camel@localhost.localdomain>
	<20061021192539.4a00cc3e.seanlkml@sympatico.ca>
	<1161478005.9241.210.camel@localhost.localdomain>
	<20061021212645.2f9ba751.seanlkml@sympatico.ca>
	<1161487417.9241.220.camel@localhost.localdomain>
	<20061021233014.d4525a1d.seanlkml@sympatico.ca>
	<20061022100028.GQ75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Sun Oct 22 13:47:30 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbbnb-0007dY-F8
	for gcvbg-bazaar-ng@m.gmane.org; Sun, 22 Oct 2006 13:47:28 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gbbkm-0002ss-7c; Sun, 22 Oct 2006 12:44:32 +0100
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <seanlkml@sympatico.ca>) id 1Gbbkh-0002s7-Td
	for bazaar-ng@lists.canonical.com; Sun, 22 Oct 2006 12:44:29 +0100
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by
	BAYC1-PASMTP06.bayc1.hotmail.com over TLS secured channel with
	Microsoft SMTPSVC(6.0.3790.1830); Sun, 22 Oct 2006 04:47:38 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GbaoY-0000ob-EZ; Sun, 22 Oct 2006 06:44:22 -0400
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
Message-Id: <20061022074422.50dcbee6.seanlkml@sympatico.ca>
In-Reply-To: <20061022100028.GQ75501@over-yonder.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 22 Oct 2006 11:47:38.0343 (UTC)
	FILETIME=[DF80BF70:01C6F5CF]
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29722>

On Sun, 22 Oct 2006 05:00:28 -0500
"Matthew D. Fuller" <fullermd@over-yonder.net> wrote:

> I think Jeff's actually meaning the other way around.  We're confident
> through experience of the utility of the single revnos.  We're NOT (at
> least, I'm not) so convinced of the utility and usability of the
> dotted ones; they haven't gone through the crucible of experience yet.
> 

Yes, that's the way I took what he said as well.

Bzr revnos (dotted or otherwise) can not be guaranteed to be stable
in a truly distributed system.   Now it's clear that you folks
just don't really care about that and you're happy enough that they
work out fine for your uses.  That's a fair enough decision to make;
there's no law that says you have to care about the situations where
there will be clashes and/or the numbers will change.  Git makes
a different choice, and for my money it's a better choice.

Cheers,
Sean
