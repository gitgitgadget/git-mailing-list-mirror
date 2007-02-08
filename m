From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Correct some language in fast-import documentation.
Date: Thu, 8 Feb 2007 19:39:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702081937260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070208075851.GB3950@spearce.org> <20070208082850.GA4334@informatik.uni-freiburg.de>
 <7vveidyqw5.fsf@assigned-by-dhcp.cox.net> <20070208183243.GA30673@spearce.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1015483955-1170959969=:22628"
Cc: Junio C Hamano <junkio@cox.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 19:39:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFEBD-0006de-6A
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 19:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbXBHSjc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 13:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752422AbXBHSjc
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 13:39:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:38376 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752413AbXBHSjb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 13:39:31 -0500
Received: (qmail invoked by alias); 08 Feb 2007 18:39:30 -0000
X-Provags-ID: V01U2FsdGVkX1/D3spQKSvDSn55O5yYTfluszfBlk5eMM/pZSOTvu
	gZXA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070208183243.GA30673@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39071>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1015483955-1170959969=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 8 Feb 2007, Shawn O. Pearce wrote:

> Junio C Hamano <junkio@cox.net> wrote:
> > Uwe Kleine-König  <ukleinek@informatik.uni-freiburg.de> writes:
> > 
> > > Shawn O. Pearce wrote:
> > >> Minor documentation improvements, as suggested on the Git mailing
> > >> list by Horst H. von Brand and Karl Hasselstr~A(P)m.
> > > you have an encoding problem here     ---------^
> > >
> > > That "o umlaut" seems to be UTF-8 encoded, but the headers of you mail
> > > claim iso-8859-1.
> > 
> > I noticed it, too.  This seems to be purely between the
> > format-patch output and the mailing list.  In Shawn's tree, the
> > corresponding commit f842fdb0 does not have the encoding
> > problem.
> 
> Yes, correct.  I took great care to copy Uwe's name from a prior
> commit of his in git.git, to make sure I got it spelled correctly
> in the commit message.  :)

Sometimes I think Uwe just took on another name for the sake of being an 
Umlaut-PITA ;-)

Ciao,
Jöhännës "Dschö" Schindëlin


---1148973799-1015483955-1170959969=:22628--
