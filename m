From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] --pretty=format: on-demand format expansion
Date: Fri, 9 Nov 2007 22:18:54 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711092218150.4362@racer.site>
References: <4733AEA6.1040802@lsrfire.ath.cx> <Pine.LNX.4.64.0711090122470.4362@racer.site>
 <4734CD78.4000704@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Nov 09 23:19:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqcCB-0006wy-QU
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 23:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210AbXKIWTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 17:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755192AbXKIWTG
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 17:19:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:43738 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755091AbXKIWTF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 17:19:05 -0500
Received: (qmail invoked by alias); 09 Nov 2007 22:19:02 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp001) with SMTP; 09 Nov 2007 23:19:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18PPvMELXMPpqH2hSWeU0/B4VZgRSFfqlIrpBh5Qi
	A6PdxE7caYXO2p
X-X-Sender: gene099@racer.site
In-Reply-To: <4734CD78.4000704@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64264>

Hi,

On Fri, 9 Nov 2007, Ren? Scharfe wrote:

> Johannes Schindelin schrieb:
> > Hi,
> > 
> > On Fri, 9 Nov 2007, Ren? Scharfe wrote:
> > 
> >>  strbuf.c |   24 ++++++
> >>  strbuf.h |    3 +
> >>  pretty.c |  276 ++++++++++++++++++++++++++++++++++----------------------------
> > 
> > I would be so grateful if you could (trivially) split up this patch into 
> > the addition of strbuf_expend() (with a small example in the commit 
> > message), and a patch that uses it in pretty.c.
> 
> Makes sense.  Will do next time.

You mean next time you write strbuf_expand()?

;-)  I saw that Junio already applied your patch as is.  Hmm.

Ciao,
Dscho
