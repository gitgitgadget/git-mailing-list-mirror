From: walt <wa1ter@myrealbox.com>
Subject: Re: My first git success [not quite]
Date: Sat, 14 Jan 2006 12:41:04 -0800
Organization: none
Message-ID: <dqbnl1$3si$1@sea.gmane.org>
References: <dq8epd$k28$1@sea.gmane.org> <Pine.LNX.4.64.0601130909290.3535@g5.osdl.org> <dqb5vg$a09$1@sea.gmane.org> <Pine.LNX.4.64.0601141117120.13339@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jan 14 21:41:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExsDb-00087d-Tc
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 21:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWANUlm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 15:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWANUlm
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 15:41:42 -0500
Received: from main.gmane.org ([80.91.229.2]:15051 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751096AbWANUll (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jan 2006 15:41:41 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ExsDN-00084u-Ex
	for git@vger.kernel.org; Sat, 14 Jan 2006 21:41:34 +0100
Received: from adsl-69-234-195-63.dsl.irvnca.pacbell.net ([69.234.195.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jan 2006 21:41:33 +0100
Received: from wa1ter by adsl-69-234-195-63.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jan 2006 21:41:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-195-63.dsl.irvnca.pacbell.net
User-Agent: Mail/News 1.6a1 (X11/20060114)
In-Reply-To: <Pine.LNX.4.64.0601141117120.13339@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14684>

Linus Torvalds wrote:
[...]
> Now, what happens is that when you change branches with a dirty tree, the 
> "git checkout" will do one of two things:
> 
>  - if the dirty files are _identical_ in both branches...

I'm sorry to be quibbling over semantics, truly I am!  But here
is my confusion:  if modified-but-uncommitted (hence dirty) files
are not associated with *any* branch, then how could 'dirty' files
be 'in' both branches (or 'in' any branch at all)?

Thanks for your continued patience with me!  I hate to distract you
from your real work -- I can only hope that others are learning as
much from your answers as I am.
