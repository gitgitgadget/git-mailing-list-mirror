From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: msysgit: does git gui work?
Date: Sat, 11 Aug 2007 10:40:14 +0200
Message-ID: <20070811084014.GA3774@steel.home>
References: <3CD6111C-13B5-444C-A28C-A7445C8A199B@zib.de> <E886F099-5E9F-4785-A560-F9AAAA4E4C1F@zib.de> <20070810053158.GJ24573@spearce.org> <B6C82889-ABE0-4B3D-A455-A2EE1CE48297@zib.de> <Pine.LNX.4.64.0708101113380.21857@racer.site> <81b0412b0708100440l116f934ft22d3ac3c71e2e7cf@mail.gmail.com> <ACBC67D9E9124ECFAAF6B0E20CE660C0@ntdev.corp.microsoft.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 10:40:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJmWE-0004Cf-N5
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 10:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617AbXHKIkT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 04:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753448AbXHKIkT
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 04:40:19 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:36268 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbXHKIkS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 04:40:18 -0400
Received: from tigra.home (Fad1e.f.strato-dslnet.de [195.4.173.30])
	by post.webmailer.de (mrclete mo8) (RZmta 11.0)
	with ESMTP id f064dbj7B3bY0U ; Sat, 11 Aug 2007 10:40:15 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 7EB46277BD;
	Sat, 11 Aug 2007 10:40:15 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id E4212BDCE; Sat, 11 Aug 2007 10:40:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ACBC67D9E9124ECFAAF6B0E20CE660C0@ntdev.corp.microsoft.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClPJCg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55593>

Dmitry Kakurin, Sat, Aug 11, 2007 08:10:50 +0200:
> From: "Alex Riesen" <raa.lkml@gmail.com>
> >>In my experience, Windows users (not Mac users forced to use Windows)
> >>_expect_ "." to be in the PATH.
> >
> >...because they _cannot_ know otherwise. In Windows, you cannot remove "."
> >from PATH, it is implicitly in it.
> >It is actually worse than that: the system directories are in PATH
> >too. Unconditionally.
> >Yes, the same system directories all them programs put their .exes into.
> 
> This is not true:

I didn't say that. _They_ say that:

    http://msdn2.microsoft.com/en-us/library/ms682425.aspx
