From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT] [PATCH RFC v1 0/5] Add (static) ignore functionality to EGit
Date: Mon, 30 Mar 2009 07:18:26 +0100
Message-ID: <200903300818.26983.robin.rosenberg.lists@dewire.com>
References: <cover.1238102327.git.ferry.huberts@pelagic.nl> <49D0151B.6070408@magma.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>, git@vger.kernel.org
To: Jonathan Gossage <jgossage@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 08:20:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoArh-0000mP-7e
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 08:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717AbZC3GTL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 02:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754575AbZC3GTJ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 02:19:09 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:47288 "EHLO
	pne-smtpout2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753912AbZC3GTJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 02:19:09 -0400
Received: from sleipner.localnet (90.232.103.65) by pne-smtpout2-sn2.hy.skanova.net (7.3.129)
        id 4873CA9503F1368A; Mon, 30 Mar 2009 08:18:33 +0200
User-Agent: KMail/1.11.1 (Linux/2.6.27-14-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <49D0151B.6070408@magma.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115084>

m=E5ndag 30 mars 2009 02:40:59 skrev Jonathan Gossage <jgossage@gmail.c=
om>:
> Ferry Huberts wrote:
> Eclipse supplies a repository-independent ignore file list as part of=
 the repository-type independent Team support. A first step, which woul=
d provide useful functionality would be to populate your cache with thi=
s list and enable it's use in the Egit plugin. This would accomplish th=
e goal of enabling EGit to use ignore lists in an immediately useful wa=
y with minimal effort. As a second stage you can add support for pickin=
g up Git specific files and updating them from Eclipse.

The current EGit obeys the Eclipse ignore rules already, so no there is=
 no need to hurry just for that feature.

-- robin
