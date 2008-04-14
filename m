From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: Git Wiki improvements
Date: Mon, 14 Apr 2008 11:48:46 -0400
Message-ID: <BAYC1-PASMTP10A8BA28CC2999519EA0B2AEE80@CEZ.ICE>
References: <60CC37BF5A3B73428D0BB9B6A26B9669019D95DA@yvrmail1.corp.navcan.ca>
	<200804140303.22624.jnareb@gmail.com>
	<8aa486160804140106m570d3fb9va0081d8a0d42870@mail.gmail.com>
	<alpine.DEB.1.00.0804141555350.28504@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Santi =?ISO-8859-1?B?QulqYXI=?= <sbejar@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"Pack, Dylan" <PackD@navcanada.ca>,
	"Pack, Dylan" <sarpulhu@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 14 18:06:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlQwJ-0007XB-DH
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 17:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760833AbYDNPtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 11:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754404AbYDNPtJ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 11:49:09 -0400
Received: from bay0-omc2-s10.bay0.hotmail.com ([65.54.246.146]:47071 "EHLO
	bay0-omc2-s10.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754659AbYDNPtI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2008 11:49:08 -0400
Received: from BAYC1-PASMTP10 ([65.54.191.183]) by bay0-omc2-s10.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 14 Apr 2008 08:49:03 -0700
X-Originating-IP: [70.54.4.86]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([70.54.4.86]) by BAYC1-PASMTP10.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Mon, 14 Apr 2008 08:49:02 -0700
Received: from bud.attic.local ([10.10.10.20])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1JlRrK-0005Tl-Up; Mon, 14 Apr 2008 12:48:47 -0400
In-Reply-To: <alpine.DEB.1.00.0804141555350.28504@racer>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.8; x86_64-pc-linux-gnu)
X-OriginalArrivalTime: 14 Apr 2008 15:49:02.0802 (UTC) FILETIME=[0FFACB20:01C89E47]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79512>

On Mon, 14 Apr 2008 15:58:29 +0100 (BST)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

Hi Johannes,

> While this would seem a good idea from the viewpoint of using as much of 
> your own dog food as possible, I think that the Wiki is fine as-is.  
> Especially since I like to spend more time hacking on Git than on the 
> Wiki, and I expect most people to feel the same.

It's not just about eating dog food but improving the chances that people
use and update the wiki with useful stuff.  Adding the ability for people to
clone a  copy of the wiki onto their own systems and use it offline can only
help.  If people are permitted to push changes back to the wiki it has the
potential to change the rules of the game in a positive way[1].

A change in infrastructure like this might increase the number of contributors
of tutorial and faq answers.   It might even give developers a little more time
with the source rather than documentation and user support.  Then again it
might not, but we'll never know unless it's tried.

> IOW I think a change of system is just not worth the effort.

There seems little reason to discourage someone from taking a stab at it if
they're so inclined.

Cheers,
Sean

[1]  Ikiwiki uses the Markdown format which has fewer features than say
Asciidoc but is very Emacs/Vim friendly so it's not hard to imagine people
cloning the wiki and using it this way.
