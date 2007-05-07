From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: FFmpeg considering GIT
Date: Mon, 7 May 2007 14:30:55 +0200
Message-ID: <20070507123055.GB3255@diana.vm.bytemark.co.uk>
References: <loom.20070502T111026-882@post.gmane.org> <20070503180016.GB21333@informatik.uni-freiburg.de> <20070503200013.GG4489@pasky.or.cz> <loom.20070504T143538-533@post.gmane.org> <87y7k4lahq.wl%cworth@cworth.org> <20070505133543.GC3379@diana.vm.bytemark.co.uk> <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org> <alpine.LFD.0.98.0705051511020.17381@woody.linux-foundation.org> <alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org> <17983.6136.147062.346626@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon May 07 14:33:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl2PU-0005DS-Tl
	for gcvg-git@gmane.org; Mon, 07 May 2007 14:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933388AbXEGMdp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 7 May 2007 08:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933571AbXEGMdp
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 08:33:45 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4422 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933388AbXEGMdo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 08:33:44 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hl2Mh-0000wZ-00; Mon, 07 May 2007 13:30:55 +0100
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <17983.6136.147062.346626@cargo.ozlabs.ibm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46455>

On 2007-05-07 22:13:44 +1000, Paul Mackerras wrote:

> I have thought about rewriting it in a different language, but I
> haven't found anything that really appeals. I don't want to go to
> C/GTK or C/Qt since that would make it hard to port to Windows and
> MacOS AFAIK. Python/Tk would be a possibility, but I have never
> learnt python and I'm actually not all that comfortable with having
> to do things the object-oriented way.
>
> Any suggestions?

wxWidgets (http://www.wxwidgets.org/) is a cross-platform C++ library
that seems popular. There are bindings for lots of languages,
including Python (http://www.wxpython.org/).

  "wxWidgets lets developers create applications for Win32, Mac OS X,
  GTK+, X11, Motif, WinCE, and more using one codebase. It can be used
  from languages such as C++, Python, Perl, and C#/.NET."

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
