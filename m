From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 19:49:45 -0400
Message-ID: <20061018194945.3e5105e7.seanlkml__29789.188996847$1161405144$gmane$org@sympatico.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<45349162.90001@op5.se> <453536AE.6060601@utoronto.ca>
	<200610172301.27101.jnareb@gmail.com>
	<45354AD0.1020107@utoronto.ca>
	<BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
	<45355CBB.80108@utoronto.ca>
	<BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE>
	<eh64tk$rug$2@sea.gmane.org>
	<BAYC1-PASMTP069C473B2E79389E5BFC92AE0F0@CEZ.ICE>
	<eh6dgr$pu8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Sat Oct 21 06:32:21 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb8Wx-0006ng-5w
	for gcvbg-bazaar-ng@m.gmane.org; Sat, 21 Oct 2006 06:32:19 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GapNX-0007lw-2I; Fri, 20 Oct 2006 09:05:19 +0100
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]
	helo=BAYC1-PASMTP08.CEZ.ICE)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <seanlkml@sympatico.ca>) id 1GaLAT-0005ty-2G
	for bazaar-ng@lists.canonical.com; Thu, 19 Oct 2006 00:49:49 +0100
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP08.CEZ.ICE
	over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); 
	Wed, 18 Oct 2006 16:58:25 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GaKEL-00036Y-Uc; Wed, 18 Oct 2006 18:49:45 -0400
To: Charles Duffy <cduffy@spamcop.net>
Message-Id: <20061018194945.3e5105e7.seanlkml@sympatico.ca>
In-Reply-To: <eh6dgr$pu8$1@sea.gmane.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 18 Oct 2006 23:58:25.0859 (UTC)
	FILETIME=[4D01B930:01C6F311]
X-Mailman-Approved-At: Fri, 20 Oct 2006 09:04:05 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29580>

On Wed, 18 Oct 2006 18:31:32 -0500
Charles Duffy <cduffy@spamcop.net> wrote:

> Granted, I'm speaking with my IT hat on here rather than my developer 
> hat -- but plugins are a pretty clear usability win.

Sure they can be.  But their value I think is overstated, especially
in an open source project where anyone can grab a copy of the source
and update it with a trial feature.  This updated copy can be wrapped
in a nice GUI installer just as easily as any plugin.

Now, I suppose plugins let end users mix and match trial features
slightly easier, but hopefully your base package isn't so devoid of
features that this is honestly necessary.

As Petr pointed out, all this comes to Bzr essentially for free
since it's a part of python.  So be it, but I've yet to hear an
example where plugins were anything more than a minor convenience
rather than a fundamental win over the way Git is developing.

For an example, just look how few lines of git were needed to
implement the essential features of the bzr bundle feature.
With no plugins or monkey business needed ;o)

Sean
