From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: how to change/fake the time for next commit ?
Date: Fri, 23 Nov 2007 00:34:36 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711230032320.27959@racer.site>
References: <46d6db660711221629j5d294a5dp4771778e38b14962@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 01:35:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvMVu-0002Et-Uh
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 01:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbXKWAem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 19:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbXKWAem
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 19:34:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:48981 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752042AbXKWAel (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 19:34:41 -0500
Received: (qmail invoked by alias); 23 Nov 2007 00:34:39 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp001) with SMTP; 23 Nov 2007 01:34:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19SPvJZyqFSutggc2FeIve8fVEu17UZWwKg93fo2P
	5ylFwJPOsAcwyD
X-X-Sender: gene099@racer.site
In-Reply-To: <46d6db660711221629j5d294a5dp4771778e38b14962@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65862>

Hi,

On Fri, 23 Nov 2007, Christian MICHON wrote:

> I already did such approach in the past by script, but usually the
> dates of commit are the timestamps of current tar imports.

Have you tried setting the environment variables GIT_COMMITTER_DATE and 
GIT_AUTHOR_DATE before committing?

Hth,
Dscho
