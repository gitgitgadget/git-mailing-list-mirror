From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git (stable)
Date: Sun, 29 Jul 2007 12:27:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707291224460.14781@racer.site>
References: <7v4plqoyg5.fsf@assigned-by-dhcp.cox.net> <7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net>
 <7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com> <7vy7idydqa.fsf@assigned-by-dhcp.pobox.com>
 <7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com> <7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net>
 <7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net> <7vvec4synj.fsf_-_@assigned-by-dhcp.cox.net>
 <85zm1g3nze.fsf@lola.goethe.zz> <85bqdw27mb.fsf@lola.goethe.zz>
 <20070729031612.GB17204@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 29 13:28:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF6x3-0001W0-Mw
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 13:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761478AbXG2L1j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 07:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761488AbXG2L1i
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 07:27:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:34544 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762148AbXG2L1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 07:27:25 -0400
Received: (qmail invoked by alias); 29 Jul 2007 11:27:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp022) with SMTP; 29 Jul 2007 13:27:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/yXP9VdvbyKJKPQbtU0D4sLePak/y90yIwEkMw3x
	PI7kZBGy8hzY7S
X-X-Sender: gene099@racer.site
In-Reply-To: <20070729031612.GB17204@thunk.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54104>

Hi,

On Sat, 28 Jul 2007, Theodore Tso wrote:

> So I really am beginning to think the right answer is to give up on 
> using git-mergetool to support anything other than basic emacs users 
> (who just use emacs as an editor, what a concept), and for the H4rd C0re 
> emacs l33t, they can use a contrib/git-mergetool.el that does everything 
> inside emacs.  Since these are the people who want emacs to be their 
> desktop, their shell, *and* their window manager, they will probably be 
> happier that way....

Well, maybe not happier.  But at least they will be forced to write a 
patch (if they really want to use git _their_ way, and they'll have to 
defend their patch if they break all other people's work flow), instead of 
writing a lot of long and useless emails.

IOW I do not think "we" have to do something about it.

Ciao,
Dscho
