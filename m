From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [GIT PATCH] USB patches for 2.6.17
Date: Thu, 22 Jun 2006 22:01:47 +0200
Message-ID: <20060622200147.GA10712@mars.ravnborg.org>
References: <20060621220656.GA10652@kroah.com>
	<Pine.LNX.4.64.0606211519550.5498@g5.osdl.org>
	<20060621225134.GA13618@kroah.com>
	<Pine.LNX.4.64.0606211814200.5498@g5.osdl.org>
	<20060622181826.GB22867@kroah.com>
	<20060622183021.GA5857@kroah.com>
	<Pine.LNX.4.64.0606221239100.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
X-From: linux-usb-devel-bounces@lists.sourceforge.net Thu Jun 22 22:03:03 2006
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
Envelope-to: linux-usb-devel-3@m.gmane.org
Received: from lists-outbound.sourceforge.net ([66.35.250.225])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtVNJ-0007Ww-GE
	for linux-usb-devel-3@m.gmane.org; Thu, 22 Jun 2006 22:02:02 +0200
Received: from sc8-sf-list1-new.sourceforge.net (unknown [10.3.1.93])
	by sc8-sf-spam2.sourceforge.net (Postfix) with ESMTP
	id E144512C5E; Thu, 22 Jun 2006 13:01:59 -0700 (PDT)
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FtVNG-00039s-S3 for linux-usb-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 13:01:58 -0700
Received: from pasmtpa.tele.dk ([80.160.77.114] helo=pasmtp.tele.dk)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FtVNG-0003Zz-Ew
	for linux-usb-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 13:01:58 -0700
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk
	[80.160.117.125])
	by pasmtp.tele.dk (Postfix) with ESMTP id 7745E8013CD;
	Thu, 22 Jun 2006 22:01:54 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 3932C43C062; Thu, 22 Jun 2006 22:01:47 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606221239100.5498@g5.osdl.org>
User-Agent: Mutt/1.5.11
X-Spam-Score: 1.0 (+)
X-Spam-Report: Spam Filtering performed by sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	Report problems to
	http://sf.net/tracker/?func=add&group_id=1&atid=200001
	1.0 FORGED_RCVD_HELO       Received: contains a forged HELO
X-BeenThere: linux-usb-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: <linux-usb-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>, 
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>, 
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22364>

> I'm just constantly surprised by how people don't even seem to realize 
> what it can do sometimes. Part of it is that development has been pretty 
> active (and some of the things it can do simply weren't there three months 
> ago), but part of it must be because people don't even expect it to be 
> able to do something like that.

Personally I'm still missing two things:
1) A command to let me see what this Linus guy have applied compared to
my tree - without touching anything in my tree. bk changes -R
2) A dry-run of a fetch+pull. I can do that if I really study the man
pages I know. But "git pull --dry-run" would be more convinient.

Other than that I will say that I'm pleased with the funtionality that
I use - that's maybe 10% of the possibilities...

	Sam

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
