From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: How to merge git://repo.or.cz/git-gui into git.git
Date: Sun, 28 Oct 2007 12:14:43 +0100
Message-ID: <20071028111443.GA29183@xp.machine.xx>
References: <46dff0320710280357u23927960hd204760b3d664ce2@mail.gmail.com> <46dff0320710280400v523e2130nd3286a88a4920a9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yin Ping <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 12:15:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im66i-0002S7-Cp
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 12:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbXJ1LOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 07:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbXJ1LOv
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 07:14:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:56708 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751215AbXJ1LOu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 07:14:50 -0400
Received: (qmail invoked by alias); 28 Oct 2007 11:14:48 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp034) with SMTP; 28 Oct 2007 12:14:48 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/w7x9VJx/w+wYusT3BugHT114dIzwEWKkUEqNRH1
	lvMIy+3Deb1jdT
Content-Disposition: inline
In-Reply-To: <46dff0320710280400v523e2130nd3286a88a4920a9c@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62553>

On Sun, Oct 28, 2007 at 07:00:54PM +0800, Yin Ping wrote:
> On 10/28/07, Yin Ping <pkufranky@gmail.com> wrote:
> 
> > When I type
> > gtlg --topo-order --pretty=oneline --abbrev-commit e92ea624 -p
> Sorry, my fault. gtlg is an alias for git-log
> 
> > franky
> >
> 

Have a look at the subtree merge strategy [1] and at the following
explanations how git-gui got initally merged.

-Peter

[1]: http://www.gelato.unsw.edu.au/archives/git/0702/40139.html
[2]: http://www.gelato.unsw.edu.au/archives/git/0702/39661.html
