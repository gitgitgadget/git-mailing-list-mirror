From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 10:24:54 -0400
Message-ID: <20061022102454.b9dea693.seanlkml__19614.2076900744$1161527145$gmane$org@sympatico.ca>
References: <1161478005.9241.210.camel@localhost.localdomain>
	<20061021212645.2f9ba751.seanlkml@sympatico.ca>
	<1161487417.9241.220.camel@localhost.localdomain>
	<20061021233014.d4525a1d.seanlkml@sympatico.ca>
	<20061022100028.GQ75501@over-yonder.net>
	<20061022074422.50dcbee6.seanlkml@sympatico.ca>
	<20061022130322.GS75501@over-yonder.net>
	<20061022092845.233deb43.seanlkml@sympatico.ca>
	<20061022133336.GT75501@over-yonder.net>
	<20061022094041.77c06cc7.seanlkml@sympatico.ca>
	<20061022135702.GU75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Sun Oct 22 16:25:43 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbeGj-0004qi-S9
	for gcvbg-bazaar-ng@m.gmane.org; Sun, 22 Oct 2006 16:25:42 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GbeG6-0000o0-0h; Sun, 22 Oct 2006 15:25:02 +0100
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]
	helo=BAYC1-PASMTP08.CEZ.ICE)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <seanlkml@sympatico.ca>) id 1GbeG2-0000nb-Ci
	for bazaar-ng@lists.canonical.com; Sun, 22 Oct 2006 15:24:58 +0100
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP08.CEZ.ICE
	over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); 
	Sun, 22 Oct 2006 07:33:40 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GbdJv-00011f-4z; Sun, 22 Oct 2006 09:24:55 -0400
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
Message-Id: <20061022102454.b9dea693.seanlkml@sympatico.ca>
In-Reply-To: <20061022135702.GU75501@over-yonder.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 22 Oct 2006 14:33:40.0609 (UTC)
	FILETIME=[1179E710:01C6F5E7]
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29750>

On Sun, 22 Oct 2006 08:57:02 -0500
"Matthew D. Fuller" <fullermd@over-yonder.net> wrote:

> You keep insisting that there's a PROBLEM here.  You're right, I don't
> see one.  I KNOW the numbers only refer to a branch, I KNOW that when
> you're talking about a different branch the numbers are meaningless,
> and I'm perfectly fine with that because referring to revisions on *A*
> branch is exactly what I USE the numbers for.

Light goes on.  Okay.  So a bzr "branch" is only ever editable on a 
single machine.  So there is no distributed development on top of a 
bzr "branch".  Everyone else just has read-only copies of it.  In this
way you ensure that there is never a conflict of the revno's.  I'm not
sure of the ramifications of this but at least I get where you're coming
from now.

Sean
