From: Dirk Wallenstein <halsmit@t-online.de>
Subject: Re: [PATCH] howto: Use all-space indentation in ASCII art
Date: Tue, 16 Jul 2013 20:38:12 +0200
Message-ID: <20130716183812.GA11138@bottich>
References: <20130715164658.GA8675@bottich>
 <7v61wba3gu.fsf@alter.siamese.dyndns.org>
 <20130716082413.GA27283@bottich>
 <20130716182627.GM14690@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Thomas Ackermann <th.acker@arcor.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 20:38:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzA8s-00009b-45
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 20:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933425Ab3GPSi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 14:38:26 -0400
Received: from mailout06.t-online.de ([194.25.134.19]:36645 "EHLO
	mailout06.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933165Ab3GPSiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 14:38:25 -0400
Received: from fwd11.aul.t-online.de (fwd11.aul.t-online.de )
	by mailout06.t-online.de with smtp 
	id 1UzA8i-00067D-KR; Tue, 16 Jul 2013 20:38:20 +0200
Received: from localhost (r1nvSyZvwhti+dlYetcgQlzLKqJIYhVPmt4xDLWIitpRrHX8p49LEJbM1JkSz6SQ-Q@[178.202.218.27]) by fwd11.t-online.de
	with esmtp id 1UzA8c-1Cy1gG0; Tue, 16 Jul 2013 20:38:14 +0200
Content-Disposition: inline
In-Reply-To: <20130716182627.GM14690@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ID: r1nvSyZvwhti+dlYetcgQlzLKqJIYhVPmt4xDLWIitpRrHX8p49LEJbM1JkSz6SQ-Q
X-TOI-MSGID: f0e5055e-460a-4a5d-9935-6eadf54d9842
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230573>

On Tue, Jul 16, 2013 at 11:26:27AM -0700, Jonathan Nieder wrote:
> Dirk Wallenstein wrote:
> 
> > Those text files are installed as documentation (at least on my distribution).
> 
> That's probably a distribution bug (or a git makefile bug, depending
> on how you look at it).  It would be better to ship the HTML
> documentation, converted to text, instead of keeping the version with
> markup including occasional random \ signs, linkgit:, ``, etc.
They are also installed if I only use Git's makefile.
> 
> What distribution do you use?  (As maintainer of packaging for a Linux
> distro, I know at least one that is guilty of this.)

Ubuntu.
As an aside, I had to run manual creation as root.  Otherwise it did hang
(XMLTO).  Is that an Ubuntu bug?  Sorry, just because you seem to know
about this.

-- 
Cheers,
  Dirk
