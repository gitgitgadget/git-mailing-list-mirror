From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: how about removing --exec-path?
Date: Sat, 26 Jul 2008 04:49:06 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807260448210.26810@eeepc-johanness>
References: <20080725094015.GA22077@blimp.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alex Riesen <fork0@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Jul 26 04:49:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMZqH-0002pV-4G
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 04:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbYGZCsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 22:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbYGZCsH
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 22:48:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:48857 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751898AbYGZCsG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 22:48:06 -0400
Received: (qmail invoked by alias); 26 Jul 2008 02:48:03 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp015) with SMTP; 26 Jul 2008 04:48:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19by/Ao3vFbs7z8px3NcWIsnHtndguYd0puED/qSz
	7rHmWFz9cD1ORx
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080725094015.GA22077@blimp.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90157>

Hi,

On Fri, 25 Jul 2008, Alex Riesen wrote:

> The thing has at least this problem: is not passed to upload-pack when
> running fetch.

It should be added to PATH, and so it is passed to upload-pack, amongst 
others, in a sense.

Ciao,
Dscho
