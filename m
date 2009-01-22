From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] user-manual: Simplify the user configuration.
Date: Thu, 22 Jan 2009 18:28:12 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901221827370.3586@pacific.mpi-cbg.de>
References: <1232561365-5919-1-git-send-email-felipe.contreras@gmail.com> <7v8wp4e5wn.fsf@gitster.siamese.dyndns.org> <94a0d4530901211319t8126611wc1437848631fe988@mail.gmail.com> <831vuvfh7t.fsf@kalahari.s2.org> <94a0d4530901220857q1027c05bs137dcc0244a1cc5a@mail.gmail.com>
 <7v1vuv8dqy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 18:29:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ3N1-0005gK-5x
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 18:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097AbZAVR2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 12:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754724AbZAVR2J
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 12:28:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:49740 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754296AbZAVR2I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 12:28:08 -0500
Received: (qmail invoked by alias); 22 Jan 2009 17:28:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp029) with SMTP; 22 Jan 2009 18:28:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18y9Dd906cyhK9Esif6rpMZL86OMHUwf38pGdERAX
	fGnv7LgxDoUkHF
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v1vuv8dqy.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106776>

Hi,

On Thu, 22 Jan 2009, Junio C Hamano wrote:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > On Thu, Jan 22, 2009 at 6:17 PM, Hannu Koivisto <azure@iki.fi> wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >>
> >>> This brings back my previous question: where is the home directory in
> >>> a Windows system?
> >>
> >> It's where %HOMEDRIVE%%HOMEPATH% points to.
> >
> > I thought it was something like that. Do we want something like that
> > in the manual, or should we assume Windows users know that?
> 
> Funny; while I was test driving Msysgit (I wrote the report in my blog
> pages some time ago), I got curious about this exact issue.  I thought the
> choice of $HOME at that path was quite natural even for me who does not
> usually use Windows.

That's what they said when they convinced me that /home/<user>/ was not a 
natural place on Windows.

Ciao,
Dscho
