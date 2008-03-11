From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 01/10] "git read-tree -m" and the like require worktree
Date: Tue, 11 Mar 2008 16:06:42 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803111605530.3873@racer.site>
References: <cover.1204453703.git.pclouds@gmail.com>  <20080302103316.GA8902@laptop>  <alpine.LSU.1.00.0803111400430.3873@racer.site> <fcaeb9bf0803110757i5f31c6b9w3b0e65af401e3ca0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 16:08:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ64P-0001Ht-Rb
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 16:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081AbYCKPGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 11:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754057AbYCKPGi
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 11:06:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:39856 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754021AbYCKPGh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 11:06:37 -0400
Received: (qmail invoked by alias); 11 Mar 2008 15:06:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 11 Mar 2008 16:06:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19MZZJAC1VMLcuUzTIurW4vi/jUto4USTm2GMMQGD
	KM9fzC2VS9J3HR
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0803110757i5f31c6b9w3b0e65af401e3ca0@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76861>

Hi,

On Tue, 11 Mar 2008, Nguyen Thai Ngoc Duy wrote:

> On Tue, Mar 11, 2008 at 8:02 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> >  How about
> >
> >         git read-tree -m without -i requires work tree
> >
> >  Hmm?
> 
> I thought that was the patch was about. Did I write the patch so bad? :(

I meant as a replacement for your commit subject (which I found pretty 
hard to understand, harder than the patch itself).

Ciao,
Dscho
