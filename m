From: Sean <seanlkml@sympatico.ca>
Subject: Re: merge time
Date: Mon, 30 Jul 2007 07:33:52 -0400
Message-ID: <20070730073352.51ab68ec.seanlkml@sympatico.ca>
References: <498048.62681.qm@web51002.mail.re2.yahoo.com>
	<alpine.LFD.0.999.0707292000190.4161@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707292011170.4161@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Matthew L Foster <mfoster167@yahoo.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 13:34:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFTVh-0004WG-6E
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 13:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760522AbXG3Ld4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 07:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760456AbXG3Ld4
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 07:33:56 -0400
Received: from bay0-omc2-s25.bay0.hotmail.com ([65.54.246.161]:27052 "EHLO
	bay0-omc2-s25.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758875AbXG3Ldz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2007 07:33:55 -0400
Received: from BAYC1-PASMTP10.bayc1.hotmail.com ([65.54.191.183]) by bay0-omc2-s25.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Mon, 30 Jul 2007 04:33:55 -0700
X-Originating-IP: [69.156.137.240]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.137.240]) by BAYC1-PASMTP10.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Mon, 30 Jul 2007 04:34:51 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IFTVZ-0003Hr-H4; Mon, 30 Jul 2007 07:33:53 -0400
In-Reply-To: <alpine.LFD.0.999.0707292011170.4161@woody.linux-foundation.org>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.13; i686-pc-linux-gnu)
X-OriginalArrivalTime: 30 Jul 2007 11:34:52.0001 (UTC) FILETIME=[A4CDFD10:01C7D29D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54226>

On Sun, 29 Jul 2007 20:16:01 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:


> 	gitk v2.6.23-rc1..
> 
>   to show what is new after -rc1 (or "gitk @{2.days.ago}.." to see what 
>   is new in _your_ tree in the last two days or whatever).

It sounds like that would be the proper way to address the issue
within Gitweb as well.  Assuming the issue is users wanting to
see changes since a specific release, offering a "Commits since tag"
option or some such should resolve it.

Sean
