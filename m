From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: sr/gfi-options, was Re: What's cooking in git.git (Aug 2009,
 #04;  Sun, 23)
Date: Mon, 24 Aug 2009 15:09:21 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908241456400.28290@iabervon.org>
References: <7v1vn2qb29.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0908241641390.11375@intel-tinevez-2-302> <fabb9a1e0908241145p2a1fe59fgef42a4c46209f154@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1334616383-1251140961=:28290"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 21:09:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfev4-0005Jp-5S
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 21:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbZHXTJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 15:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752936AbZHXTJU
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 15:09:20 -0400
Received: from iabervon.org ([66.92.72.58]:40738 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752542AbZHXTJU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 15:09:20 -0400
Received: (qmail 19387 invoked by uid 1000); 24 Aug 2009 19:09:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Aug 2009 19:09:21 -0000
In-Reply-To: <fabb9a1e0908241145p2a1fe59fgef42a4c46209f154@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126960>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1334616383-1251140961=:28290
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 24 Aug 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Mon, Aug 24, 2009 at 07:45, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
> > On Sun, 23 Aug 2009, Junio C Hamano wrote:
> >> * sr/gfi-options (2009-08-13) 3 commits
> >>  - fast-import: test the new option command
> >>  - fast-import: add option command
> >>  - fast-import: put option parsing code in seperate functions
> >>
> >> What is this used by?
> >
> > By a hg-fast-import Sverre was writing for me:
> 
> And possibly also by the p4 helper I think?

Nope, I didn't actually need it. I think the cvs helper wants it, though, 
since that is using the marks file.

	-Daniel
*This .sig left intentionally blank*
--1547844168-1334616383-1251140961=:28290--
