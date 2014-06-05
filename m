From: Thomas Koch <thomas@koch.ro>
Subject: Re: Best practices/conventions for tags and references in commit message
Date: Thu, 5 Jun 2014 16:10:40 +0200
Message-ID: <201406051610.41373.thomas@koch.ro>
References: <201405271326.36031.thomas@koch.ro> <CALKQrgfYfXyXs0K+tq6xXNaQ-J1VdwJ7iodyE3s8X8wHN8WuvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 16:32:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsYiJ-0000Su-Aa
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 16:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbaFEOcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 10:32:11 -0400
Received: from koch.ro ([88.198.2.104]:37243 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbaFEOcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 10:32:09 -0400
X-Greylist: delayed 1281 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Jun 2014 10:32:09 EDT
Received: from 97-41.106-92.cust.bluewin.ch ([92.106.41.97] helo=x121eofhwr1202.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <thomas@koch.ro>)
	id 1WsYNT-0000ol-0S; Thu, 05 Jun 2014 16:10:47 +0200
User-Agent: KMail/1.13.7 (Linux/3.14-0.bpo.1-amd64; KDE/4.8.4; x86_64; ; )
In-Reply-To: <CALKQrgfYfXyXs0K+tq6xXNaQ-J1VdwJ7iodyE3s8X8wHN8WuvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250839>

On Tuesday, May 27, 2014 03:49:24 PM Johan Herland wrote:
> Search the mailing list archives for git-interpret-trailers. It's coming.
Nice!

I started a table to collect how different projects or tools use trailers:
https://git.wiki.kernel.org/index.php/CommitMessageConventions#Trailers

It would be nice to see more examples and in the long run to have some best 
practices recommended by gits documentation and supported across different bug 
trackers, changelog generators, statistic generators, repository viewers, 
etc..

Regards,

Thomas Koch
