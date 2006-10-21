From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 16:58:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610211655130.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> 
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca>
	<200610171030.35854.jnareb@gmail.com> <vpqejt76vgz.fsf@ecrins.imag.fr> 
	<20061017073839.3728d1e7.seanlkml@sympatico.ca>
	<20061021141328.GE29843@artax.karlin.mff.cuni.cz>
	<BAYC1-PASMTP116A2EE9056E50B25534D5AE020@CEZ.ICE>
	<845b6e870610210919i6d086654g3881343e6a3c9f84@mail.gmail.com>
	<Pine.LNX.4.64.0610211353070.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, bazaar-ng@lists.canonical.com,
	Sean <seanlkml@sympatico.ca>, Jan Hudec <bulb@ucw.cz>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Sun Oct 22 01:59:24 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbQkK-0004kG-51
	for gcvbg-bazaar-ng@m.gmane.org; Sun, 22 Oct 2006 01:59:20 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GbQk9-0000ki-AI; Sun, 22 Oct 2006 00:59:09 +0100
Received: from smtp.osdl.org ([65.172.181.4])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <torvalds@osdl.org>) id 1GbQk7-0000kd-Kk
	for bazaar-ng@lists.canonical.com; Sun, 22 Oct 2006 00:59:08 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9LNwvaX017597
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 21 Oct 2006 16:58:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9LNwuQ2004898;
	Sat, 21 Oct 2006 16:58:56 -0700
To: =?ISO-8859-1?Q?Erik_B=E5gfors?= <zindar@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0610211353070.3962@g5.osdl.org>
X-Spam-Status: No, hits=-0.48 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29692>



On Sat, 21 Oct 2006, Linus Torvalds wrote:
> 
> And that work-flow is definitely not "distributed" it's much closer to 
> "disconnected centralized".

Side note: the only reason I think that distinction is worth making at all 
is when comparing git to bzr, and even then this is a fairly subtle 
distinction, and probably not a huge deal in practice.

I obviously think git is a nicer distributed design, but in the end, if 
you compare to something like CVS or SVN that isn't even disconnected, the 
difference between git and bzr in this sense is basically zero. 

So I sound like I care, but at the same time, I realize very well that 
when coming from a totally centralized world, the details we're arguing 
are _so_ not important.

			Linus
