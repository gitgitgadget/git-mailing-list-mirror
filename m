From: Eric Blake <ebb9@byu.net>
Subject: Re: latest git manual pages have some problems
Date: Mon, 01 Oct 2007 20:26:44 -0600
Message-ID: <4701AC64.1080508@byu.net>
References: <224419.55330.qm@web59112.mail.re1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: cygwin@cygwin.com,  git@vger.kernel.org
X-From: cygwin-return-136540-goc-cygwin=m.gmane.org@cygwin.com Tue Oct 02 04:26:14 2007
Return-path: <cygwin-return-136540-goc-cygwin=m.gmane.org@cygwin.com>
Envelope-to: goc-cygwin@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IcXSM-0001DU-Ks
	for goc-cygwin@gmane.org; Tue, 02 Oct 2007 04:25:55 +0200
Received: (qmail 9488 invoked by alias); 2 Oct 2007 02:25:46 -0000
Received: (qmail 9476 invoked by uid 22791); 2 Oct 2007 02:25:45 -0000
X-Spam-Check-By: sourceware.org
Received: from rwcrmhc15.comcast.net (HELO rwcrmhc15.comcast.net) (216.148.227.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 02 Oct 2007 02:25:44 +0000
Received: from [192.168.0.103] (c-67-166-125-73.hsd1.co.comcast.net[67.166.125.73])           by comcast.net (rwcrmhc15) with ESMTP           id <20071002022542m1500c915te>; Tue, 2 Oct 2007 02:25:43 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <224419.55330.qm@web59112.mail.re1.yahoo.com>
X-IsSubscribed: yes
Mailing-List: contact cygwin-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin.cygwin.com>
List-Unsubscribe: <mailto:cygwin-unsubscribe-goc-cygwin=m.gmane.org@cygwin.com>
List-Subscribe: <mailto:cygwin-subscribe@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin/>
List-Post: <mailto:cygwin@cygwin.com>
List-Help: <mailto:cygwin-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-owner@cygwin.com
Mail-Followup-To: cygwin@cygwin.com
Delivered-To: mailing list cygwin@cygwin.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59654>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Cary R. on 10/1/2007 2:22 PM:
> The latest update to git (1.5.3.1) changed how the manual pages are
> displayed.

And that change would probably be the upgrade from asciidoc 8.2.2 to 8.2.3.

> Specifically references to other git manual pages are no longer
> shown by name. Instead a reference number with a cross reference at the
> end of the file is given. From a usability standpoint this is a real
> inconvenience. I am hoping that something changed in the programs used to
> generate the manual pages and a new flag/etc. is required to get the
> original behavior.

I've noticed it, and I hate it too.  But don't know enough about asciidoc
or the git documentation process to know how to go about fixing it, so I'm
adding the git list on this mail for advice.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
volunteer cygwin git packager
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHAaxj84KuGfSFAYARAh1LAKDFEURDhGU25xC8Djdxc12Y1Dz6VQCgz++c
WD09VOPGyWeVySdjOau8a3c=
=X91K
-----END PGP SIGNATURE-----
