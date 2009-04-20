From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Oldest supported Perl version
Date: Mon, 20 Apr 2009 19:29:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904201926531.6771@intel-tinevez-2-302>
References: <76718490904200759l24e1bd9exe0e1b60f7b2847a7@mail.gmail.com> <20090420181806.229b833e@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Witten <mfwitten@gmail.com>, git <git@vger.kernel.org>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Apr 20 19:30:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvxKR-0004UF-CV
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 19:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbZDTR3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 13:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752260AbZDTR3I
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 13:29:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:43058 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752140AbZDTR3I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 13:29:08 -0400
Received: (qmail invoked by alias); 20 Apr 2009 17:29:04 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp035) with SMTP; 20 Apr 2009 19:29:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+hXrhOP7ahGqIwlWBH1XAbqbz5NvA8tOIihCDIET
	rkzumylNNFHaol
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090420181806.229b833e@pc09.procura.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117008>

Hi,

On Mon, 20 Apr 2009, H.Merijn Brand wrote:

> * defined-or is available in any version of perl 5.8.x is the binary
>   was built with the appropriate patch, which is available on my CPAN
>   directory:
>   ftp://download.xs4all.nl/pub/mirror/CPAN/authors/id/H/HM/HMBRAND/
>   These patches still include the 'err' keyword

Do you realize how much _pain_ you cause here?  I just do not have the 
_time_ to recompile Perl 5.8 for msysGit!

Bah,
Dscho "who thinks that a lot of people would not introduce dependencies 
so lightly if they actually felt the pain they cause"
