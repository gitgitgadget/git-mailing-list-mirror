From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "git add" and absolute paths
Date: Mon, 28 Jan 2008 12:43:16 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801281241550.23907@racer.site>
References: <916BAC14-A5E4-4666-A29E-2CDF114DCD87@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git mailing list <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 13:44:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJTLN-0007b0-4a
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 13:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397AbYA1Mnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 07:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755191AbYA1Mnh
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 07:43:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:48918 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754882AbYA1Mng (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 07:43:36 -0500
Received: (qmail invoked by alias); 28 Jan 2008 12:43:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp025) with SMTP; 28 Jan 2008 13:43:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zKsdvgitzPjqc9hjhfRX7Fk7C3BGAR/Nyl3w9ZW
	p4N0T61avl0EAK
X-X-Sender: gene099@racer.site
In-Reply-To: <916BAC14-A5E4-4666-A29E-2CDF114DCD87@wincent.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71884>

Hi,

On Mon, 28 Jan 2008, Wincent Colaiuta wrote:

> I was somewhat surprised the other day to see that you can't pass 
> absolute paths to "git add":

I think this is in the same ballpark as the wish to normalise paths passed 
to git add.  Not something for 1.5.4.

Personally, I have to admit that this was never an itch of mine, so I'll 
probably not "fix" it.

Ciao,
Dscho
