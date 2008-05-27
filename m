From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC/PATCH] git-what: explain what to do next
Date: Tue, 27 May 2008 15:52:59 +0200
Message-ID: <20080527135259.GA12551@cuci.nl>
References: <1211877299-27255-1-git-send-email-sbejar@gmail.com> <alpine.DEB.1.00.0805271151430.30431@racer> <8aa486160805270558v40e7faabh7d4426731693f917@mail.gmail.com> <alpine.DEB.1.00.0805271411520.30431@racer> <8aa486160805270637m3fc640bfr9fa51eb917460e5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Santi B?jar <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 15:54:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0zct-0000D2-F7
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 15:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757494AbYE0NxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 09:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757474AbYE0NxD
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 09:53:03 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:56057 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757386AbYE0NxA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 09:53:00 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 305E45461; Tue, 27 May 2008 15:52:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8aa486160805270637m3fc640bfr9fa51eb917460e5c@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83016>

Santi B?jar wrote:
>On Tue, May 27, 2008 at 3:12 PM, Johannes Schindelin
><Johannes.Schindelin@gmx.de> wrote:
>> Sure it is.  But cluttering up the commands for something that is not
>> really proven to be wanted by many is IMO inferior.

>This is an argument against git-whatzzup.sh in general. Point taken.

Not really.  It's an argument against cluttering up the existing core
with this stuff.

>Moreover, this could be integrated in "git status".

I personally have no need for such a thing, but in effect it is the git
commandline equivalent of MS-Office "Clippy", which provides a hands-on
tutorial in git while you are trying to use it (with the subtle yet
important difference that it only provides advice when called).

So if you'd keep it confined to a shell script externally from the core
commands, I could imagine a lot of new (or occasional) users of git being
rather happy with an "interactive manual/hands-on tutorial" like this.
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.

Skiing beyond this point may result in death and/or loss of skiing privileges.
