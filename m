From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: merges and git log --stat
Date: Thu, 6 May 2010 21:26:16 +0200
Message-ID: <20100506192616.GS4599@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 06 21:26:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA6iH-0008PN-Rg
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 21:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756760Ab0EFT0T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 15:26:19 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:54169 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab0EFT0S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 15:26:18 -0400
Received: from [127.0.1.1] (p5B130578.dip0.t-ipconnect.de [91.19.5.120])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MSmoL-1NkdDQ0hVt-00Rklq; Thu, 06 May 2010 21:26:17 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX1/ei5H5YTc/GxJwS7bsmPv2m+PtNjpwOEekrKf
 S6KK9IFumBTHYLcgLZrMvhqtAodY/Xz7fV5JWX+FBB9o7GyuX5
 E65DAhL+tYeG1R7Mwj0Kw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146489>

Hi,

I've just noticed that 'git log --stat' does not print the diffstat
for merge commits.  Is this intentional?

Thanks,
G=E1bor
