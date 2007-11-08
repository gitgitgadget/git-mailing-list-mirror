From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Inconsistencies with git log
Date: Thu, 8 Nov 2007 10:24:05 +0100
Message-ID: <6E9C860B-E2DC-4F4A-9B80-72189F5479DC@wincent.com>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com> <Pine.LNX.4.64.0711072242230.4362@racer.site> <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com> <Pine.LNX.4.64.0711072255420.4362@racer.site> <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com> <Pine.LNX.4.64.0711072309380.4362@racer.site> <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 10:24:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq3d7-0000aH-UB
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 10:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758416AbXKHJYN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 04:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758329AbXKHJYM
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 04:24:12 -0500
Received: from wincent.com ([72.3.236.74]:51981 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758226AbXKHJYL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Nov 2007 04:24:11 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lA89O6gq029017;
	Thu, 8 Nov 2007 03:24:08 -0600
In-Reply-To: <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63975>

El 8/11/2007, a las 0:29, Jon Smirl escribi=F3:

> It's not consistent. git log with no parameters is relative to the
> project root, git log with a parameter is relative to the current
> directory.

A minor quibble: git log with no parameters isn't "relative" to =20
anything. It shows the history of the entire project. There is no =20
inconsistency.

Cheers,
Wincent
