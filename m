From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GPL v2 authoritative answer on stored code as a derived work
Date: Thu, 28 Jan 2016 09:16:45 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601280913450.2964@virtualbox>
References: <6D15DFBB73355B4E9EFB1AD5EF9FCA3184242757@NZ-EXCHANGE1.fphcare.com> <xmqqzivtfphe.fsf@gitster.mtv.corp.google.com> <C0429EC95C2F44528E2A1336FB7A2D98@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Smith <Jonathan.Smith@fphcare.co.nz>,
	git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Jan 28 09:17:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOhlJ-0007gp-IE
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 09:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934968AbcA1IQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 03:16:57 -0500
Received: from mout.gmx.net ([212.227.15.19]:63082 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934118AbcA1IQz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 03:16:55 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M86PB-1aB2j80eLR-00vgCB; Thu, 28 Jan 2016 09:16:47
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <C0429EC95C2F44528E2A1336FB7A2D98@PhilipOakley>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:EPAYRQmJtDjpkqHwifEL4idOpOFIkka64B25X2Sye250spGudXD
 J22EORy797uZvGXlcBj9jcwZdypuiUxtrXwBmpy4GnouJMKESaR9x+aYsrKPpFQoq6zXz1e
 wmyj3jxZVa0SnvxeAf/lnbUfpVTuqs9rrUrrTBIXK4M8eF4nr1ThRiS6m1AqhxRecVQ7P2+
 jJyuzh04Q+VQB61WnkZ7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8kDwv8cap3I=:NxV9P5H1TLUwm5avZ9JlkY
 +aSzV3pTUgesnjAafLD4LeS/c/lOZx6FuyccA6wFree2ta6PWrjirXL9B0U2r9VzodnipE6IY
 /AbWDgRSaIG1cH+H1fdnTTSA0uyxnUQXWATE/Z/jFuyD4OqMU/8CRnB3PeEtDqNRxLA6mwRLi
 Lo9NGsz4jTOqYKgXXTUkCxE+NGMA60uYZQyWRgqHcifTiA+eDIX/WKZIpnkX+10qyFGLIRikW
 UdAaATsOnrW6WDZOXtDsr6m+14VmB9DT94pCosLW7DokKetSE7sCeGfsXI2LQFQKKUaji1ViZ
 eOW5GPPHwseja2iJR7otdi9nY+7n/TqVjJoliutgf9dK8Crh2/XYWmVq2uD3M1JjtAlTMLF2o
 Ckyq95rhpN82osY1trIMguAdCQTj9u6UodavrfuPgEcWqGJyj4TOBARbM6D9Q2G7FKVLVKQzo
 KahF53fKsufPLM9Ici4AIQE94FuHBGk6gAGsaSWZUplE7HoaO+lTvNPf99BiQ0Cfrbz6hJ1wQ
 v4ymjhKEV9Z5v91Zc9TZ9RiWeC5KjB95ZEz1rDEaiFSiUbWRe6g0PZWtySt7PxtXH4a1vpI0X
 WaXksqqv/V3zHgW8j+ykR15n8SrHnF1Ud8Pq+pb0DbQ2ArOwu7ginm+PwXDz6AldFuEbxUDIv
 qrhL/0+S2ZLDdcF73osn3jjHgXVRnk/ODlAvszrkNz1OOOBQLkZGSVRaIxIwzEVsqDHiLhbrM
 0l+pbvdzw83T6XZ9hPffjwxShKLvHX6t8AlBMNEAyOPmKtJ0jo/hsauhw0zr3QSk9bQbVPum 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284985>

Hi Philip,

On Wed, 27 Jan 2016, Philip Oakley wrote:

> From: "Junio C Hamano" <gitster@pobox.com>
> > Jonathan Smith <Jonathan.Smith@fphcare.co.nz> writes:
> >
> > > It's pretty clear that code stored in a Git repository isn't
> > > considered a derived work of Git, regardless of whether it is used
> > > in a commercial context or otherwise.
> 
> I'm guessing here, but I suspect that while its 'pretty clear' to Jonathan,
> that he has met others who aren't so clear or trusting, and it's that
> distrustful community that would need convincing.

It is not so much distrust as something you could take to court, I guess,
because an *authoritative* answer was asked for. Now, the question is a
legal one, so it is pretty clear (;-)) to me that only a lawyer could give
that answer.

Having said that, I know of plenty of companies storing their proprietary
code in Git repositories, and I would guess that they cleared that with
their lawyers first.

Jonathan, please do not take that as any indication that I try to give
this answer: if you want an authoritative answer to your question, you
really need to consider asking a lawyer.

Ciao,
Dscho
