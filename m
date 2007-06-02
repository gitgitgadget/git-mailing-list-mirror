From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [mingw port] git plumbing piping with CR/NL
Date: Sun, 3 Jun 2007 01:09:39 +0200
Message-ID: <20070602230939.GB25254@steel.home>
References: <fcaeb9bf0706011123ue4ceaf2i12569c63d1d92584@mail.gmail.com> <20070601231816.GC6360@steel.home> <fcaeb9bf0706011656p2145afe0k8be9797d250566df@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 01:09:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HucjI-0006NO-Vp
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 01:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761892AbXFBXJo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 19:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762076AbXFBXJo
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 19:09:44 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:25989 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761892AbXFBXJn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 19:09:43 -0400
Received: from tigra.home (Fad9b.f.strato-dslnet.de [195.4.173.155])
	by post.webmailer.de (fruni mo27) (RZmta 7.1)
	with ESMTP id F0008cj52LWtGw ; Sun, 3 Jun 2007 01:09:40 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 1CD97277BD;
	Sun,  3 Jun 2007 01:09:40 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id E3707BE86; Sun,  3 Jun 2007 01:09:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0706011656p2145afe0k8be9797d250566df@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClFkd9w=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48957>

Nguyen Thai Ngoc Duy, Sat, Jun 02, 2007 01:56:54 +0200:
> >Why does your grep _alters_ the input, instead of filtering it, btw?
> 
> I have no idea. It's grep from MKS Toolkit FYI.
>

Looks like it is buggy
