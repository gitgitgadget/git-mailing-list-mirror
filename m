From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 06:23:41 -0400
Message-ID: <20061017062341.8a5c8530.seanlkml__27004.7138831162$1161331474$gmane$org@sympatico.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca>
	<Pine.LNX.4.63.0610170128350.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	<4534656B.7080105@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 10:04:20 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GapMV-0002TV-Uf
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 10:04:16 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GapMT-0007WZ-Oz; Fri, 20 Oct 2006 09:04:13 +0100
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]
	helo=BAYC1-PASMTP07.CEZ.ICE)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <seanlkml@sympatico.ca>) id 1GZm6q-0001nu-76
	for bazaar-ng@lists.canonical.com; Tue, 17 Oct 2006 11:23:44 +0100
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP07.CEZ.ICE
	over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); 
	Tue, 17 Oct 2006 03:29:28 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GZlAj-0005K6-Or; Tue, 17 Oct 2006 05:23:41 -0400
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Message-Id: <20061017062341.8a5c8530.seanlkml@sympatico.ca>
In-Reply-To: <4534656B.7080105@utoronto.ca>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Oct 2006 10:29:28.0531 (UTC)
	FILETIME=[20177A30:01C6F1D7]
X-Mailman-Approved-At: Fri, 20 Oct 2006 09:04:03 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29416>

On Tue, 17 Oct 2006 01:08:59 -0400
Aaron Bentley <aaron.bentley@utoronto.ca> wrote:

> I can use the 'bzr missing' command to check whether my branch is in
> sync with a remote branch.  Or I can use the 'pull' command to update my
> branch to a given revno in a remote branch.

The "bzr missing" command sounds like a handy one.  

Someone on the xorg mailing list was recently lamenting that git does not
have an easy way to compare a local branch to a remote one.  While this
turns out to not be a big problem in git, it might be nice to have such
a command.

Sean
