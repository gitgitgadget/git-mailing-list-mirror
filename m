From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: markdown 2 man, was Re: Git Community Book
Date: Thu, 31 Jul 2008 15:01:01 +0200
Message-ID: <20080731130101.GC18106@leksak.fem-net>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com> <20080729170955.GK32184@machine.or.cz> <d411cc4a0807291130p228f77d5r1f390090ec29aef4@mail.gmail.com> <7vwsj4edm1.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0807291957410.1779@reaper.quantumfyre.co.uk> <alpine.LSU.1.00.0807301514280.3486@wbgn129.biozentrum.uni-wuerzburg.de> <7vy73j418t.fsf@gitster.siamese.dyndns.org> <4891A0D0.6060503@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Scott Chacon <schacon@gmail.com>, Petr Baudis <pasky@suse.cz>
To: Abdelrazak Younes <younes@lyx.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 15:02:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOXnE-0000KW-Na
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 15:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbYGaNBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 09:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbYGaNBF
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 09:01:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:43064 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752741AbYGaNBD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 09:01:03 -0400
Received: (qmail invoked by alias); 31 Jul 2008 13:01:02 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp036) with SMTP; 31 Jul 2008 15:01:02 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18tnc8cRTctmZzB4u1jawediIC3viRj4KNrimPVIF
	pzmzf/Q+FuquOG
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KOXm9-0004oe-6D; Thu, 31 Jul 2008 15:01:01 +0200
Content-Disposition: inline
In-Reply-To: <4891A0D0.6060503@lyx.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90943>

Hi,

Abdelrazak Younes wrote:
> Please ignore if this is not appropriate.

Well, so I should've ignored, but I think this is worth some correction.

> Asciidoc or Markdown are tools that accommodate the _developer_, not the  
> user. I understand that these markup language are ideally suited for in  
> source documentation (thought I personally much prefer Doxygen).

http://www.methods.co.nz/asciidoc/ says
 ``AsciiDoc is a text document format for writing short documents,
   articles, books and UNIX man pages. AsciiDoc files can be translated to
   HTML and DocBook markups using the asciidoc(1) command.''

http://daringfireball.net/projects/markdown/ says
 ``Markdown is a text-to-HTML conversion tool for web writers. Markdown
   allows you to write using an easy-to-read, easy-to-write plain text
   format, then convert it to structurally valid XHTML (or HTML).''

So those are not suited for in-source documentation.

They're "lightweight" markup for documentation, very easy to read and somehow
easy to write for non-developers.
The user manual can give you an impression:
	http://repo.or.cz/w/git.git?a=blob;f=Documentation/user-manual.txt

I think, this is easier than LyX for users and developers..

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
