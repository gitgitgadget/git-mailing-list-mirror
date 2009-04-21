From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/2] Minor cleanup and bugfixing in git-notes.sh
Date: Tue, 21 Apr 2009 02:51:34 +0200
Message-ID: <200904210251.34945.johan@herland.net>
References: <200904210239.21974.johan@herland.net>
 <200904210241.10073.johan@herland.net>
 <alpine.DEB.1.00.0904210248560.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 21 02:53:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw4EZ-0004ea-JI
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 02:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238AbZDUAvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 20:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754217AbZDUAvh
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 20:51:37 -0400
Received: from mx.getmail.no ([84.208.15.66]:54185 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753014AbZDUAvh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 20:51:37 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KIF00EWOEDZ7V20@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 21 Apr 2009 02:51:35 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KIF009V2EDZEN70@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 21 Apr 2009 02:51:35 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.4.21.3716
User-Agent: KMail/1.11.2 (Linux/2.6.29-ARCH; KDE/4.2.2; x86_64; ; )
In-reply-to: <alpine.DEB.1.00.0904210248560.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117056>

On Tuesday 21 April 2009, Johannes Schindelin wrote:
> On Tue, 21 Apr 2009, Johan Herland wrote:
> > The following changes are made:
> > - Rename $MESSAGE to $MSG_FILE which better describes its purpose
> > - Make sure not only $MSG_FILE is removed upopn completion, but also
> >   $GIT_INDEX_FILE
> > - Remove stray "GIT_NOTES_REF=" in front of "git log ..." command
>
> Valid points.  Mind if I squash this into the commit adding git-notes.sh?

No problem


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
