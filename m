From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [ANNOUNCE] tig-0.13
Date: Thu, 15 Jan 2009 16:05:13 +0100
Message-ID: <20090115150513.GA9993@chistera.yi.org>
References: <20090113233643.GA28898@diku.dk> <20090114232456.GA6937@b2j> <20090114235607.GA5546@diku.dk> <20090115014617.GC6937@b2j> <20090115130659.GA18081@diku.dk> <20090115145003.GA6938@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 16:07:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNTnr-0002WW-Uq
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 16:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbZAOPFR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 10:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbZAOPFQ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 10:05:16 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:3069
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066AbZAOPFP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 10:05:15 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id F1912801C0EA
	for <git@vger.kernel.org>; Thu, 15 Jan 2009 16:05:13 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LNTmT-0003Qg-7X
	  for git@vger.kernel.org; Thu, 15 Jan 2009 16:05:13 +0100
Content-Disposition: inline
In-Reply-To: <20090115145003.GA6938@b2j>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105830>

* bill lam [Thu, 15 Jan 2009 22:50:03 +0800]:

> On Thu, 15 Jan 2009, Jonas Fonseca wrote:
> > presence of a {/usr/incude/}ncursesw/ncurses.h header. Where are th=
e
> > unicode ncurses.h files found on your system?

> on ubuntu,
> /usr/incude/ncursesw/curses.h=20
> /usr/incude/ncursesw/ncurses.h  ( just a sym link to curses.h above )=
=20

You should send the output of ./configure, and publish the resulting
config.log file somewhere.

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
Man is certainly stark mad; he cannot make a flea, yet he makes gods by=
 the
dozens.
                -- Michel de Montaigne
