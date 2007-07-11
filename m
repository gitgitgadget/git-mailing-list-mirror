From: Sean <seanlkml@sympatico.ca>
Subject: Re: cg switch -l doesn't work when branches point to the same
 commit
Date: Wed, 11 Jul 2007 16:34:46 -0400
Message-ID: <20070711163446.cb8d9c52.seanlkml@sympatico.ca>
References: <f158199e0707110559q43c290b4x2caee13cac46cf29@mail.gmail.com>
	<81b0412b0707110636u77b56f1biccb221489933972a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Bradford Smith" <bradford.carl.smith@gmail.com>,
	git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 22:35:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8iud-0005gA-8B
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 22:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755720AbXGKUfs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 16:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755534AbXGKUfs
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 16:35:48 -0400
Received: from bay0-omc3-s14.bay0.hotmail.com ([65.54.246.214]:27404 "EHLO
	bay0-omc3-s14.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755587AbXGKUfr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jul 2007 16:35:47 -0400
Received: from BAYC1-PASMTP07.bayc1.hotmail.com ([65.54.191.167]) by bay0-omc3-s14.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Wed, 11 Jul 2007 13:35:47 -0700
X-Originating-IP: [65.93.40.159]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.40.159]) by BAYC1-PASMTP07.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Wed, 11 Jul 2007 13:36:39 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1I8iuX-0002On-8w; Wed, 11 Jul 2007 16:35:45 -0400
In-Reply-To: <81b0412b0707110636u77b56f1biccb221489933972a@mail.gmail.com>
X-Mailer: Sylpheed 2.4.1 (GTK+ 2.10.11; i686-pc-linux-gnu)
X-OriginalArrivalTime: 11 Jul 2007 20:36:39.0468 (UTC) FILETIME=[2EEA8EC0:01C7C3FB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52199>

On Wed, 11 Jul 2007 15:36:39 +0200
"Alex Riesen" <raa.lkml@gmail.com> wrote:

> Cogito is unmaintained ATM.

Wonder who maintains the http://git.kernel.org site?  The front page
there still suggests the use of Cogito.

Sean
