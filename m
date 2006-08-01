From: Pavel Roskin <proski@gnu.org>
Subject: Re: Why I love GIT but use Subversion (was: GIT user survey)
Date: Mon, 31 Jul 2006 23:50:17 -0400
Message-ID: <1154404217.32333.7.camel@dv>
References: <4d8e3fd30607230123m459aa1cle2ab8c1c1dd0fcd2@mail.gmail.com>
	 <4d8e3fd30607300248m36b4038dv1fcd1f3716503905@mail.gmail.com>
	 <1prv3rw6ldo9s$.dlg@jwmittag.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 05:50:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7lH1-00071r-Q8
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 05:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbWHADuY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 31 Jul 2006 23:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWHADuY
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 23:50:24 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:20930 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751117AbWHADuY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 23:50:24 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1G7lGw-0004Nu-If
	for git@vger.kernel.org; Mon, 31 Jul 2006 23:50:22 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1G7lGs-0008Sj-1b; Mon, 31 Jul 2006 23:50:18 -0400
To: =?ISO-8859-1?Q?J=F6rg?= W Mittag <Joerg.Mittag@Web.De>
In-Reply-To: <1prv3rw6ldo9s$.dlg@jwmittag.my-fqdn.de>
X-Mailer: Evolution 2.7.4 (2.7.4-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24570>

Hello, J=F6rg!

On Tue, 2006-08-01 at 03:45 +0200, J=F6rg W Mittag wrote:

> In my case the operating environment is the Windows Explorer or
> Eclipse and my workflow is basically dragging and dropping files with
> the mouse.  I can do just that with TortoiseSVN and Subclipse without
> having to change the way I normally work.

I understand you don't really care about changesets (i.e. committing
several files at once and recording it as a single operation).  In that
case, would git-cvsserver satisfy your needs?  Would it make any
difference if there were a similar Subversion emulator?  Would DAV
support make any difference?

> With Git I would constantly
> need to switch back and forth between Explorer or Eclipse and Cygwin.

With git-cvsserver, you can run it and forget about it.  The rest would
be handled through the CVS interface.

--=20
Regards,
Pavel Roskin
