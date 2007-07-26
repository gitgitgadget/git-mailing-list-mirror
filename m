From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 19:18:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707261917150.14781@racer.site>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com> 
 <46A8378A.6050201@xs4all.nl>  <Pine.LNX.4.64.0707260737170.14781@racer.site>
  <f329bf540707260002p117937tc9bc70050ef87838@mail.gmail.com> 
 <fcaeb9bf0707260429l327f446bq73a8a0a13cd77cf1@mail.gmail.com> 
 <46d6db660707260521u15c2bd85j806d48e0f51a3b9@mail.gmail.com> 
 <fcaeb9bf0707260537y4233abaamadf4cb6190ea0eeb@mail.gmail.com> 
 <Pine.LNX.4.64.0707261534550.14781@racer.site> 
 <fcaeb9bf0707260807u476719e3rec2dcf5f780013c0@mail.gmail.com> 
 <Pine.LNX.4.64.0707261638100.14781@racer.site>
 <fcaeb9bf0707260911y4091b525kc6b89beb82ec7dc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 20:19:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE7vm-0004aE-0O
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 20:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934462AbXGZSSz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 14:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934549AbXGZSSy
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 14:18:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:51111 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933542AbXGZSSx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 14:18:53 -0400
Received: (qmail invoked by alias); 26 Jul 2007 18:18:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 26 Jul 2007 20:18:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ftcQFJoffOSkPTLqIz7jtwubvoHy06G/T7Q2N8a
	b9TkZV3QRyk2f7
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0707260911y4091b525kc6b89beb82ec7dc7@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53852>

Hi,

On Thu, 26 Jul 2007, Nguyen Thai Ngoc Duy wrote:

> On 7/26/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > Earlier, Nguyen Thai Ngoc Duy wrote:
> 
> > > - MinGW busybox (or gitbox as I call it now) utilizes compat/mingw.c 
> > > and other stuff like run-command.c... Making it separate (as source 
> > > code) duplicates code for nothing.
> > 
> > It is not duplication.  It is forking.  Which is a good thing.
> 
> I still don't see why duplicating compat/*, git-compat-util.h,
> run-command.[ch]... and keeping fixing bugs in two places is a good
> thing.

Actually, it would pretty easy to set up a tracking script with Git, I 
guess.  But I can look into that once you finished your gitbox.  
Thanks for doing it BTW...

Ciao,
Dscho
