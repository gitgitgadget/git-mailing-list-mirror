From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH,v2] git-checkout(1): mention fate of extraneous files
Date: Tue, 20 Jan 2009 00:42:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901200040550.3586@pacific.mpi-cbg.de>
References: <877i4teq78.fsf@jidanni.org> <87priivrt3.fsf_-_@jidanni.org> <200901191716.59373.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jidanni@jidanni.org, gitster@pobox.com, git@vger.kernel.org,
	markus.heidelberg@web.de
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 00:44:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP3mz-0005pK-6E
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 00:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755050AbZASXmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 18:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754407AbZASXmu
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 18:42:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:45369 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753830AbZASXmt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 18:42:49 -0500
Received: (qmail invoked by alias); 19 Jan 2009 23:42:47 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 20 Jan 2009 00:42:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18cIvMbgtUc2gSVAt8hYDIONgkeI2B/IhWF1FTbsh
	h++RvxGI79sHOV
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901191716.59373.bss@iguanasuicide.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106408>

Hi,

On Mon, 19 Jan 2009, Boyd Stephen Smith Jr. wrote:

> I think you mean "No untracked content is removed,...".

As "checkout" is about switching branches, and as Git is very keen on 
avoiding loss of uncommitted changes, I think this comment is utterly 
unnecessary.  Indeed, it is rather annoying: when I read a document the 
other day, that I _had_ to read, and which was full of obvious statements, 
sure enough, I missed the single important half-sentence.

IOW do not clutter the man page with distracting stuff, please, please, 
please.

Ciao,
Dscho
