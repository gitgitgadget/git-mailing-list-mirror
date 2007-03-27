From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Meta-commits and subprojects
Date: Tue, 27 Mar 2007 13:44:55 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070327114455.GB12178@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 13:45:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWA6q-0005FI-7b
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 13:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbXC0LpA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 27 Mar 2007 07:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753822AbXC0LpA
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 07:45:00 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:46957 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753820AbXC0Lo7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2007 07:44:59 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HWA6k-0005tt-Pc
	for git@vger.kernel.org; Tue, 27 Mar 2007 13:44:58 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l2RBitgp013050
	for <git@vger.kernel.org>; Tue, 27 Mar 2007 13:44:55 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l2RBitLZ013049
	for git@vger.kernel.org; Tue, 27 Mar 2007 13:44:55 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.14+cvs20070315 (2007-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43268>

Hello,

just a (maybe silly) idea ...

If the toplevel tree were a subproject (i.e. a commit) you could
represent rebases and other commit reorderings in history.  Maybe that'=
s
a feature stgit could exploit?

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D12+mol+in+dozen
