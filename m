From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Cloning from sites with 404 overridden
Date: Mon, 20 Mar 2006 11:54:09 -0800
Message-ID: <20060320195409.GN3997@reactrix.com>
References: <e5bfff550603190252n7e3e1cbbp94e3f15c92f12d07@mail.gmail.com> <4d8e3fd30603190525o5a01fba8w5bcdedd064c213ec@mail.gmail.com> <e5bfff550603190604ne4364f3o6a862d25267a2dce@mail.gmail.com> <7vk6aqql9e.fsf@assigned-by-dhcp.cox.net> <441EF46E.5050907@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 20 20:54:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLQSP-0005rg-Jc
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 20:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWCTTyT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 20 Mar 2006 14:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWCTTyT
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 14:54:19 -0500
Received: from 241.37.26.69.virtela.com ([69.26.37.241]:32557 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S964956AbWCTTyS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Mar 2006 14:54:18 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k2KJsAKd012572;
	Mon, 20 Mar 2006 11:54:10 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k2KJs9MQ012569;
	Mon, 20 Mar 2006 11:54:09 -0800
To: Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
Content-Disposition: inline
In-Reply-To: <441EF46E.5050907@etek.chalmers.se>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17764>

On Mon, Mar 20, 2006 at 07:29:02PM +0100, Lukas Sandstr=F6m wrote:

> Perhaps a repository config option to treat a 302 as a 404?

=46WIW, it used to work that way and was modified to follow redirects b=
ack at
commit 66c9ec25553ce7332c46e2017b9c4d7c26310fff.

--=20
=46or a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
