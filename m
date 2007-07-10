From: Sean <seanlkml@sympatico.ca>
Subject: Re: mirroring between svn and git
Date: Tue, 10 Jul 2007 03:49:32 -0400
Message-ID: <20070710034932.d77da91b.seanlkml@sympatico.ca>
References: <6a9b0ede0707100025w2a37eecr8bb06e537523a003@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "satish madrage" <svmdcv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 09:50:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8AU4-0000Zx-82
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 09:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755017AbXGJHuF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 03:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755362AbXGJHuF
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 03:50:05 -0400
Received: from bay0-omc3-s7.bay0.hotmail.com ([65.54.246.207]:37784 "EHLO
	bay0-omc3-s7.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752207AbXGJHuD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jul 2007 03:50:03 -0400
Received: from BAYC1-PASMTP06.CEZ.ICE ([65.54.191.166]) by bay0-omc3-s7.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Tue, 10 Jul 2007 00:50:03 -0700
X-Originating-IP: [65.93.40.159]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.40.159]) by BAYC1-PASMTP06.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Tue, 10 Jul 2007 00:50:33 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1I8ATx-00062w-7u; Tue, 10 Jul 2007 03:50:01 -0400
In-Reply-To: <6a9b0ede0707100025w2a37eecr8bb06e537523a003@mail.gmail.com>
X-Mailer: Sylpheed 2.4.1 (GTK+ 2.10.11; i686-pc-linux-gnu)
X-OriginalArrivalTime: 10 Jul 2007 07:50:34.0015 (UTC) FILETIME=[FEF54AF0:01C7C2C6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52052>

On Tue, 10 Jul 2007 12:55:04 +0530
"satish madrage" <svmdcv@gmail.com> wrote:

> can somebody give pointers to any docs through which i can set up
> mirroring between svn and git. (i.e all svn checked in contenst shd be
> seen in git).

git-svn should do what you need and it has a pretty good man page.
You might also want to checkout the introduction here:

    http://utsl.gen.nz/talks/git-svn/intro.html


Cheers,
Sean
