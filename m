From: Nicolas Pitre <nico@cam.org>
Subject: Re: [ANNOUNCE] GIT 1.4.3
Date: Fri, 20 Oct 2006 20:47:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610202046420.12418@xanadu.home>
References: <7vejt5xjt9.fsf@assigned-by-dhcp.cox.net>
 <7v4ptylfvw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 02:48:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb51s-00083b-2c
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 02:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992761AbWJUArz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 20:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992762AbWJUArz
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 20:47:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:19888 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S2992761AbWJUArz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 20:47:55 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7G00410NJUSV40@VL-MO-MR003.ip.videotron.ca>; Fri,
 20 Oct 2006 20:47:54 -0400 (EDT)
In-reply-to: <7v4ptylfvw.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29567>

On Fri, 20 Oct 2006, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> >  - git-diff paginates its output to the tty by default.  If this
> >    irritates you, using LESS=RF might help.
> 
> I am considering the following to address irritation some people
> (including me, actually) are experiencing with this change when
> viewing a small (or no) diff.  Any objections?

I think this is an excellent idea.


Nicolas
