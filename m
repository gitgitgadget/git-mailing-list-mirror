From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: looking for "market share" analysis of SCMs.
Date: Tue, 20 May 2008 12:32:45 +0300
Message-ID: <20080520093245.GA5037@mithlond.arda.local>
References: <48329282.1040407@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Ittay Dror <ittayd@tikalk.com>
X-From: git-owner@vger.kernel.org Tue May 20 11:33:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyOEB-0004Jz-0h
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 11:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758661AbYETJdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 05:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752312AbYETJc7
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 05:32:59 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:35607 "EHLO
	kirsi2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752466AbYETJc7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 May 2008 05:32:59 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.rokki.sonera.fi (8.5.014)
        id 482C7FD60030298F; Tue, 20 May 2008 12:32:46 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JyOD7-0002HH-OM; Tue, 20 May 2008 12:32:45 +0300
Content-Disposition: inline
In-Reply-To: <48329282.1040407@tikalk.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82474>

Ittay Dror wrote (2008-05-20 11:57 +0300):

> I'm looking for a survey that analyses the market share of the major
> SCMs (including git of course). If someone knows about something like
> that, can you please point me to it? (optimally, such a survey will
> take  into account how large the projects are)

Some kind of "market share analysis" is Debian popularity contest which
gathers automatically information about what packages are installed on
people's Debian systems. Perhaps you can get some useful information
from it. I constructed a link which compares the number-of-installs of
some major SCM/VCS systems:

http://people.debian.org/~igloo/popcon-graphs/index.php?packages=darcs%2Cgit-core%2Cmercurial%2Cbzr%2Csubversion%2C+cvs&show_installed=on&want_legend=on&want_ticks=on&from_date=2003-10-01&to_date=&hlght_date=&date_fmt=%25Y-%25m&beenhere=1
