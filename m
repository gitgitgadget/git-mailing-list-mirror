From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 23:30:14 -0400
Message-ID: <20061021233014.d4525a1d.seanlkml__10280.2026238807$1161487839$gmane$org@sympatico.ca>
References: <45357CC3.4040507@utoronto.ca>
	<Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	<4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org>
	<453792A8.1010700@utoronto.ca> <878xjc2qeb.wl%cworth@cworth.org>
	<453803E6.2060309@utoronto.ca> <87ods727pn.wl%cworth@cworth.org>
	<45382120.9060702@utoronto.ca> <87irie1wvv.wl%cworth@cworth.org>
	<20061021130111.GL75501@over-yonder.net>
	<87ac3p1jn7.wl%cworth@cworth.org>
	<1161472030.9241.174.camel@localhost.localdomain>
	<20061021192539.4a00cc3e.seanlkml@sympatico.ca>
	<1161478005.9241.210.camel@localhost.localdomain>
	<20061021212645.2f9ba751.seanlkml@sympatico.ca>
	<1161487417.9241.220.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Sun Oct 22 05:30:36 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbU2m-0002kN-3X
	for gcvbg-bazaar-ng@m.gmane.org; Sun, 22 Oct 2006 05:30:36 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GbU2X-0008Cn-1Q; Sun, 22 Oct 2006 04:30:21 +0100
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]
	helo=BAYC1-PASMTP08.CEZ.ICE)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <seanlkml@sympatico.ca>) id 1GbU2U-0008Ci-1g
	for bazaar-ng@lists.canonical.com; Sun, 22 Oct 2006 04:30:18 +0100
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP08.CEZ.ICE
	over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); 
	Sat, 21 Oct 2006 20:38:59 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GbT6N-0002qZ-0m; Sat, 21 Oct 2006 22:30:15 -0400
To: Jeff Licquia <jeff@licquia.org>
Message-Id: <20061021233014.d4525a1d.seanlkml@sympatico.ca>
In-Reply-To: <1161487417.9241.220.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 22 Oct 2006 03:38:59.0750 (UTC)
	FILETIME=[9C427C60:01C6F58B]
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29707>

On Sat, 21 Oct 2006 23:23:37 -0400
Jeff Licquia <jeff@licquia.org> wrote:

> > The archives have all the posts of people claiming that there were no
> > issues with revno's and fully distributed models.  
> 
> "revno's"?  Which "revno's"? ...
> 
> OK.  So you are conflating the two.  Could someone who isn't comment?

No, actually i'm not.  Single revno's or your dotted revno's _both_ have the
same property.  They can only be local data and can not guarantee stability
in a fully distributed environment.

Sean
