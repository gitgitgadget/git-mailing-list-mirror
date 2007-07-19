From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [REVISED PATCH 2/6] Introduce commit notes
Date: Thu, 19 Jul 2007 11:05:32 +0200
Message-ID: <E4F64312-3F86-49F3-B6BD-D148AFBAB520@wincent.com>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site> <Pine.LNX.4.64.0707160022560.14781@racer.site> <7vejj96igx.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707190258550.14781@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 19 11:06:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBRy0-0003Z0-GC
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 11:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937262AbXGSJGS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 19 Jul 2007 05:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937292AbXGSJGR
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 05:06:17 -0400
Received: from wincent.com ([72.3.236.74]:59469 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758833AbXGSJGQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2007 05:06:16 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l6J962f5029777;
	Thu, 19 Jul 2007 04:06:02 -0500
In-Reply-To: <Pine.LNX.4.64.0707190258550.14781@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52952>

El 19/7/2007, a las 4:30, Johannes Schindelin escribi=F3:

> Commit notes are blobs which are shown together with the commit
> message.  These blobs are taken from the notes ref, which you can
> configure by the config variable core.notesRef, which in turn can
> be overridden by the environment variable GIT_NOTES_REF.

I was trying to look back and find out what the rationale/usage =20
scenario for these commit notes might be but Googling for 'git =20
"commit notes"' doesn't turn up much other than the original patch =20
you sent a few days ago.

Is this an evolution of the "git-note: A mechanisim for providing =20
free-form after-the-fact annotations on commits" first introduced here?=
:

<http://lists.zerezo.com/git/msg465441.html>

Cheers,
Wincent
