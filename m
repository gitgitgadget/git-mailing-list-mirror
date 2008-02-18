From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5 v2] Introduce the .gitfile
Date: Mon, 18 Feb 2008 14:12:05 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181411300.30505@racer.site>
References: <1203331463-13857-1-git-send-email-hjemli@gmail.com>  <alpine.LSU.1.00.0802181214400.30505@racer.site>  <8c5c35580802180456s75c9f857of1f727aca4673374@mail.gmail.com>  <alpine.LSU.1.00.0802181330030.30505@racer.site>
 <8c5c35580802180601h5cf01c5h583458fee61caa7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 15:13:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR6jm-0003Ob-Ha
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 15:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbYBROMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 09:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbYBROMS
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 09:12:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:37191 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750871AbYBROMR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 09:12:17 -0500
Received: (qmail invoked by alias); 18 Feb 2008 14:12:16 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 18 Feb 2008 15:12:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/fzSUhH4/fDSVAszDvoxYHZuIXG03aePi2TyDf3Y
	6bnPpBxx3s+WH0
X-X-Sender: gene099@racer.site
In-Reply-To: <8c5c35580802180601h5cf01c5h583458fee61caa7a@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74295>

Hi,

On Mon, 18 Feb 2008, Lars Hjemli wrote:

> On Feb 18, 2008 2:31 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > On Mon, 18 Feb 2008, Lars Hjemli wrote:
> >
> > > On Feb 18, 2008 1:17 PM, Johannes Schindelin wrote:
> > > > In the case of patch "1/5 => 2/5", I would even have appreciated 
> > > > an interdiff...
> > >
> > > Sorry, but I don't think I understand what you mean by interdiff.
> >
> > The tool interdiff of patchutils is really nice: you can visualise 
> > what would be the diff between the state after applying the first 
> > patch, and the state after applying the second patch, without applying 
> > anything at all:
> >
> >         $ interdiff <patch1> <patch2>
> 
> Ok, that sounds useful (I was kind of confused since 'man interdiff' 
> gave me nothing: being on slackware I'm so spoiled with preinstalled 
> dev-tools that I see no point in consulting google ;).
> 
> Something like this (possibly mangled by gmail)?

Heh, thank you!  The mangling does not matter, since this is purely for 
reviewing pleasure.

Thanks,
Dscho
