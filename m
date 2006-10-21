From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 10:23:46 -0400
Message-ID: <20061021102346.9cd3abce.seanlkml__45117.5057831735$1161440669$gmane$org@sympatico.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca>
	<200610171030.35854.jnareb@gmail.com>
	<vpqejt76vgz.fsf@ecrins.imag.fr>
	<20061017073839.3728d1e7.seanlkml@sympatico.ca>
	<20061021141328.GE29843@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Sat Oct 21 16:24:27 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbHls-0007eC-MG
	for gcvbg-bazaar-ng@m.gmane.org; Sat, 21 Oct 2006 16:24:20 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GbHlb-0003YU-Tv; Sat, 21 Oct 2006 15:24:04 +0100
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]
	helo=BAYC1-PASMTP11.CEZ.ICE)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <seanlkml@sympatico.ca>) id 1GbHlO-0003Y3-78
	for bazaar-ng@lists.canonical.com; Sat, 21 Oct 2006 15:23:53 +0100
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP11.CEZ.ICE
	over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); 
	Sat, 21 Oct 2006 07:32:38 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GbGpG-0001kU-Ph; Sat, 21 Oct 2006 09:23:46 -0400
To: Jan Hudec <bulb@ucw.cz>
Message-Id: <20061021102346.9cd3abce.seanlkml@sympatico.ca>
In-Reply-To: <20061021141328.GE29843@artax.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 21 Oct 2006 14:32:38.0468 (UTC)
	FILETIME=[C2063040:01C6F51D]
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29617>

On Sat, 21 Oct 2006 16:13:28 +0200
Jan Hudec <bulb@ucw.cz> wrote:

> Bzr is meant to be used in both ways, depending on user's choice.
> Therefore it comes with that infrastructure and you can choose whether
> you want to use it or not.

>From what we've read on this thread, bzr appears to be biased towards
working with a central repo.  That is the model that supports the use of
revnos etc that the bzr folks are so fond of.   However Git is perfectly
capable of being used in any number of models, including centralized.
Git just doesn't make the mistake of training new users into using
features that are only stable in a limited number of those models.

Sean
