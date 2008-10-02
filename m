From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: update-index --unresolve
Date: Thu, 2 Oct 2008 15:52:25 +0200
Message-ID: <20081002135224.GC6839@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 15:54:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlOcd-00051M-GS
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 15:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbYJBNw2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Oct 2008 09:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753603AbYJBNw2
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 09:52:28 -0400
Received: from francis.fzi.de ([141.21.7.5]:31971 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753559AbYJBNw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 09:52:28 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 2 Oct 2008 15:52:24 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 02 Oct 2008 13:52:24.0925 (UTC) FILETIME=[198EC0D0:01C92496]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97329>

Dear All,

the documentation says following:

  --unresolve::
         Restores the 'unmerged' or 'needs updating' state of a
         file during a merge if it was cleared by accident.

How could I clear those states by accident (or intentionally)?

Thanks,
G=E1bor
