From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] parse_commit_buffer: don't parse invalid commits
Date: Sun, 20 Jan 2008 17:11:05 +0100
Message-ID: <20080120161105.GA10830@auto.tuwien.ac.at>
References: <1200764123283-git-send-email-mkoegler@auto.tuwien.ac.at> <7vprvx8ueo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 17:11:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGcll-0002ei-CV
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 17:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbYATQLI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jan 2008 11:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753662AbYATQLH
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 11:11:07 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:43817 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbYATQLG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 11:11:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 6681C680BEAE;
	Sun, 20 Jan 2008 17:11:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UDEV3OeiOjyc; Sun, 20 Jan 2008 17:11:05 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 4CAD2680BEAB; Sun, 20 Jan 2008 17:11:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vprvx8ueo.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71181>

On Sat, Jan 19, 2008 at 11:52:47AM -0800, Junio C Hamano wrote:
> No need to resend if you allow me to amend the patch along the
> above lines (please just say so), or you could resend with
> improvements on your own.

=46eel free to change it.

mfg Martin K=F6gler
