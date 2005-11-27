From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Rss produced by git is not valid xml?
Date: Sun, 27 Nov 2005 17:18:18 +0100
Message-ID: <20051127161818.GA16351@vrfy.org>
References: <Pine.LNX.4.64.0511181314470.13959@g5.osdl.org> <Pine.LNX.4.64.0511181338460.13959@g5.osdl.org> <437E51EB.7050100@zytor.com> <Pine.LNX.4.64.0511181520390.13959@g5.osdl.org> <7vek5deam6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511181653191.13959@g5.osdl.org> <7v7jb57wud.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511190950161.13959@g5.osdl.org> <20051127025249.GA12286@vrfy.org> <7vfypioi83.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 17:20:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgPEV-0004jH-EX
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 17:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbVK0QSV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 11:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbVK0QSV
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 11:18:21 -0500
Received: from soundwarez.org ([217.160.171.123]:17839 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751094AbVK0QSV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 11:18:21 -0500
Received: by soundwarez.org (Postfix, from userid 2702)
	id A52456F9B0; Sun, 27 Nov 2005 17:18:18 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfypioi83.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12814>

On Sat, Nov 26, 2005 at 07:57:48PM -0800, Junio C Hamano wrote:
> Kay Sievers <kay.sievers@vrfy.org> writes:
> > On Sat, Nov 19, 2005 at 09:52:34AM -0800, Linus Torvalds wrote:
> >> On Sat, 19 Nov 2005, Junio C Hamano wrote:
> >> > 
> >> > Well, some people on the list seem to think UTF-8 is the one and
> >> > only right encoding, so for them if the message does not
> >> > identify what it is in, assuming UTF-8 and not doing any
> >> > conversion is probably the right thing ;-).
> >> 
> >> If you replace "assume" with "verify", then I agree.


> > I found some test code I did a while ago for validation of
> > filesystem labels, cause D-BUS diconnects your session, if you
> > send an invalid utf-8 string to the bus. :)
> 
> Thanks.  I take it that you are licensing this code to use in
> git when we doing what Linus suggests?

Sure, it's free to use under any version of the GPL git uses itself.

Thanks,
Kay
