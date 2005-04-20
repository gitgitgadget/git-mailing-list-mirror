From: Tom Lord <lord@emf.net>
Subject: [ANNOUNCEMENT] /Arch/ embraces `git'
Date: Wed, 20 Apr 2005 03:00:36 -0700 (PDT)
Message-ID: <200504201000.DAA04988@emf.net>
Cc: talli@museatech.net, torvalds@osdi.org
X-From: gnu-arch-dev-bounces@lists.seyza.com Wed Apr 20 11:57:13 2005
Return-path: <gnu-arch-dev-bounces@lists.seyza.com>
Received: from [207.166.200.220] (helo=hera.museatech.net)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1DOBwv-0007xk-8E
	for gcvad-gnu-arch-dev@gmane.org; Wed, 20 Apr 2005 11:56:49 +0200
Received: (qmail 10589 invoked by uid 110); 20 Apr 2005 10:01:01 -0000
Received: from gnu-arch-dev-bounces@lists.seyza.com by hera by uid 102 with qmail-scanner-1.20 
 (clamscan: 0.60. spamassassin: 2.60.  Clear:RC:1(127.0.0.1):. 
 Processed in 5.703696 secs); 20 Apr 2005 10:01:01 -0000
Received: from unknown (HELO hera.museatech.net) (127.0.0.1)
  by hera.museatech.net with SMTP; 20 Apr 2005 10:00:55 -0000
Delivered-To: list-gnu-arch-dev@lists.seyza.com
Received: (qmail 10529 invoked by uid 110); 20 Apr 2005 10:00:46 -0000
Received: from lord@emf.net by hera by uid 102 with qmail-scanner-1.20 
	(clamscan: 0.60. spamassassin: 2.60.  Clear:RC:1(207.166.200.201):. 
	Processed in 4.097238 secs); 20 Apr 2005 10:00:46 -0000
Received: from unknown (HELO a1.mx.alal.us) (207.166.200.201)
	by hera.museatech.net with SMTP; 20 Apr 2005 10:00:41 -0000
Received: (qmail 31636 invoked from network); 20 Apr 2005 11:14:51 -0000
Received: from emf.emf.net (HELO emf.net) (205.149.0.19)
	by a1.mx.alal.us with SMTP; 20 Apr 2005 11:14:48 -0000
Received: (from lord@localhost) by emf.net (K/K) id DAA04988;
	Wed, 20 Apr 2005 03:00:36 -0700 (PDT)
To: gnu-arch-users@gnu.org, gnu-arch-dev@lists.seyza.com, git@vger.kernel.org
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on dev.alal.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=9.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.2
X-BeenThere: gnu-arch-dev@lists.seyza.com
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: a mailing list for GNU Arch developers <gnu-arch-dev.lists.seyza.com>
List-Unsubscribe: <http://lists.seyza.com/cgi-bin/mailman/listinfo/gnu-arch-dev>, 
	<mailto:gnu-arch-dev-request@lists.seyza.com?subject=unsubscribe>
List-Archive: <http://lists.seyza.com/pipermail/gnu-arch-dev>
List-Post: <mailto:gnu-arch-dev@lists.seyza.com>
List-Help: <mailto:gnu-arch-dev-request@lists.seyza.com?subject=help>
List-Subscribe: <http://lists.seyza.com/cgi-bin/mailman/listinfo/gnu-arch-dev>, 
	<mailto:gnu-arch-dev-request@lists.seyza.com?subject=subscribe>
Sender: gnu-arch-dev-bounces@lists.seyza.com
Errors-To: gnu-arch-dev-bounces@lists.seyza.com
X-Broken-Reverse-DNS: no host name found for IP address 207.166.200.220


`git', by Linus Torvalds, contains some very good ideas and some
very entertaining source code -- recommended reading for hackers.

/GNU Arch/ will adopt `git':

>From the /Arch/ perspective: `git' technology will form the
basis of a new archive/revlib/cache format and the basis
of new network transports.

>From the `git' perspective, /Arch/ will replace the lame "directory
cache" component of `git' with a proper revision control system.

In my view, the core ideas in `git' are quite profound and deserve
an impeccable implementation.   This is practical because those ideas
are also pretty simple.

I started here:

   http://www.seyza.com/=clients/linus/tree/index.html

and for those interested in `git'-theory, a good place to start is

   http://www.seyza.com/=clients/linus/tree/src/liblob/index.html

(Linus is not literally a "client" of mine.  That's just the directory 
where this goes.)

-t
