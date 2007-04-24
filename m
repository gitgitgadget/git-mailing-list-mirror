From: Johan Herland <johherla@online.no>
Subject: Re: bug with gitweb on kernel.org
Date: Tue, 24 Apr 2007 08:40:12 +0200
Message-ID: <200704240840.12387.johherla@online.no>
References: <alpine.LFD.0.98.0704192255180.4504@xanadu.home>
 <462D4CEC.6010204@zytor.com> <462D52F3.5050508@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: "J.H." <warthog19@eaglescrag.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 08:40:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgEha-00020q-5w
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 08:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161669AbXDXGkf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 02:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161670AbXDXGkf
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 02:40:35 -0400
Received: from [84.208.20.33] ([84.208.20.33]:37905 "EHLO smtp.getmail.no"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1161669AbXDXGke (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 02:40:34 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JGZ0010TP7K9C00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 24 Apr 2007 08:40:32 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JGZ00EZ0P70G080@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 24 Apr 2007 08:40:13 +0200 (CEST)
Received: from alpha.herland ([84.210.6.109])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JGZ004S4P70BD00@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 24 Apr 2007 08:40:12 +0200 (CEST)
X-Face: zAU=Aih\K"7{XrAB#g(N4\&nMswu9hikoybx8Q}+R"A37P=[.BX&Ncc#~jS#eq,C1k,]t@=?utf-8?q?=0A=09=3Dn9=3Bz=233?=,[.?2jV^>:!ie)?R4$jL5UUfn+>uzE-QU<I%oNdJr/AAf3EoW9ps@=?utf-8?q?D8T=60Tx9=5Ei=24=0A=09?=(P%sy[{tAd,&s\0$S$mdn.;]
In-reply-to: <462D52F3.5050508@zytor.com>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45419>

On Tuesday 24 April 2007, H. Peter Anvin wrote:
> H. Peter Anvin wrote:
> > Presumably the motivation is so you know ahead of time that you can
> > invoke an XML parser rather than an SGML/HTML parser.
> >
> > Note: http://www.w3.org/TR/xhtml-media-types/ states that text/html
> > is considered acceptable for HTML-compatible XHTML 1.0 but no other
> > version of XHTML 1.0.  One of the main issues with making XHTML
> > 1.0-compatible is to make sure there is a space before the final /
> > in the last singleton: <foo /> rather than <foo/>
>
> This might also be useful reading:
>
> http://www.mozilla.org/docs/web-developer/faq.html#xhtmldiff

Along with these:

The W3C HTML and XHTML FAQ: 
http://www.w3.org/MarkUp/2004/xhtml-faq

This document seems to always be referenced in these discussions: 
http://www.hixie.ch/advocacy/xhtml


Have fun!

...Johan

-- 
Johan Herland, <johherla@online.no>
www.herland.net
