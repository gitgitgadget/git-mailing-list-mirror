From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Add submodule-support to git archive
Date: Mon, 26 Jan 2009 00:25:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901260024140.14855@racer>
References: <1232844726-14902-1-git-send-email-hjemli@gmail.com>  <20090125135340.6117@nanako3.lavabit.com>  <8c5c35580901250018x6827291cj36e6bcb10afa9b27@mail.gmail.com>  <7veiyrdszf.fsf@gitster.siamese.dyndns.org>
 <8c5c35580901251512q5058dde3rdfae81979c46c36a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 00:26:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LREMc-00004s-M0
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbZAYXYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbZAYXYk
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:24:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:47284 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750947AbZAYXYj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:24:39 -0500
Received: (qmail invoked by alias); 25 Jan 2009 23:24:37 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp068) with SMTP; 26 Jan 2009 00:24:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zbB9c2BdzXMNVLO7Ayq3XNahI/3oknDJ5b//JUI
	pUADMb4AvLKWvp
X-X-Sender: gene099@racer
In-Reply-To: <8c5c35580901251512q5058dde3rdfae81979c46c36a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107126>

Hi,

On Mon, 26 Jan 2009, Lars Hjemli wrote:

> On Sun, Jan 25, 2009 at 21:35, Junio C Hamano <gitster@pobox.com> wrote:
> 
> > Could we switch to incremental refinements once a series hits next, 
> > pretty please?
> 
> The problem in this particular case is that the design has changed so 
> much since the first iteration that we're not really talking about 
> incremental refinements but rather a different approach to the same 
> problem.
> 
> If you want me to build on top of the series in next anyways, would it
> be acceptable if the first patch on top of ee306d2d59 reverts the
> previous attempt? I think the rest of the series will be easier to
> review that way.

I'd appreciate that.

Since 'next' will be rewound eventually, that first iteration and the 
revert will disappear at some stage.

Ciao,
Dscho
