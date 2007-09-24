From: figo <rcc_dark@hotmail.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Mon, 24 Sep 2007 13:41:17 +0000 (UTC)
Message-ID: <loom.20070924T134013-959@post.gmane.org>
References: <46DDC500.5000606@etek.chalmers.se><1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 15:45:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZoFZ-0004eY-Dq
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 15:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756415AbXIXNpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 09:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756478AbXIXNpP
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 09:45:15 -0400
Received: from main.gmane.org ([80.91.229.2]:47095 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756415AbXIXNpN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 09:45:13 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IZoFC-0007Pm-FF
	for git@vger.kernel.org; Mon, 24 Sep 2007 13:45:02 +0000
Received: from dsl-189-134-63-101.prod-infinitum.com.mx ([dsl-189-134-63-101.prod-infinitum.com.mx])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 13:45:02 +0000
Received: from rcc_dark by dsl-189-134-63-101.prod-infinitum.com.mx with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 13:45:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 189.134.63.101 (Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Alexa Toolbar; InfoPath.2; Alexa Toolbar; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.0.04506; MEGAUPLOAD 2.0; .NET CLR 3.0.04506.590; .NET CLR 3.5.20706))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59048>

http://www.research.att.com/~bs/applications.html

just as Bjarne once wrote in his TC++PL, its hard to teach an old dog new 
tricks. Its even harder to give quality education about how to use something 
to someone who doesnt want to learn.

you hate high level, then continue programming operative systems, please NEVER 
DO something else. C++ was designed to give programmers high level tools and 
still being able to take care about performance.

portability wont be possible after a standard is published and some couple of 
years given to the compiler developers. C++ had its standard in 1998, and add 
two or three years for compiler development = 2002. "Quite recently", way more 
recently that your last use of C++ I can bet.
