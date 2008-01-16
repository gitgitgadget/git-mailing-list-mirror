From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 22:23:17 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801162222180.17650@racer.site>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Mark Junker <mjscod@web.de>,
	git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 23:24:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFGgF-0001EA-Lm
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 23:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756802AbYAPWXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 17:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756795AbYAPWXX
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 17:23:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:51379 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756212AbYAPWXV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 17:23:21 -0500
Received: (qmail invoked by alias); 16 Jan 2008 22:23:19 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp009) with SMTP; 16 Jan 2008 23:23:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+UtzIy4kKUxy+dbKc2lco70D5y+7rWukKtnhYA/p
	j6muHAJFzcfmQ9
X-X-Sender: gene099@racer.site
In-Reply-To: <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70754>

Hi,

On Wed, 16 Jan 2008, Kevin Ballard wrote:

> It's not using different encodings, it's all Unicode.

But that's the _point_!  It _is_ Unicode, yet it uses _different_ 
encodings of the _same_ string.

Now, this discussion gets really annoying.  The real question is: will you 
do something about it, or reply with another 500-line email?

Ciao,
Dscho
