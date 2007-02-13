From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 19:05:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702131904330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 19:06:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH22f-0000CB-FX
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 19:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbXBMSF5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 13:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbXBMSF5
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 13:05:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:41660 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751415AbXBMSF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 13:05:56 -0500
Received: (qmail invoked by alias); 13 Feb 2007 18:05:55 -0000
X-Provags-ID: V01U2FsdGVkX199xgZy/vN9wqw8k/UmDdyIzjOs5asvEgm9o99avL
	mJqg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39563>

Hi,

On Tue, 13 Feb 2007, Linus Torvalds wrote:

> Here's a patch that I think we can merge right now.

Why the haste all of a sudden? Your patch is easily applyable for anyone 
who wants to work on text/binary or arbitrary file types. No need to rush 
a developers-only patch into git.git.

Ciao,
Dscho
