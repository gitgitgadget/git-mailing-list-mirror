From: Dinakar <desas2@gmail.com>
Subject: git compile error on AIX
Date: Fri, 14 Nov 2008 11:45:18 -0800 (PST)
Message-ID: <1226691918584-1499908.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 14 20:46:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L14ck-0004Pz-3e
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 20:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbYKNTpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 14:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752864AbYKNTpU
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 14:45:20 -0500
Received: from kuber.nabble.com ([216.139.236.158]:50168 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbYKNTpT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 14:45:19 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1L14bW-0006Zt-J9
	for git@vger.kernel.org; Fri, 14 Nov 2008 11:45:18 -0800
X-Nabble-From: desas2@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101007>


Hello:
I am trying to compile git-1.6.0 on AIX 5.3 with gcc (GCC) 4.2.3. I getting
following error.
cp private-Error.pm blib/lib/Error.pm
cp Git.pm blib/lib/Git.pm
Manifying blib/man3/private-Error.3
Manifying blib/man3/Git.3
    SUBDIR templates
/usr/bin/getopt: Not a recognized flag: d
Usage: install [-c DirectoryA] [-f DirectoryB] [-i] [-m] [-M Mode] [-O
Owner]
               [-G Group] [-S] [-n DirectoryC] [-o] [-s] File [DirectoryX
...]
gmake[1]: *** [boilerplates.made] Error 2
gmake: *** [all] Error 2


I would appreciate, if you could help me to resolve this issue.

Thank you.
Dinakar
-- 
View this message in context: http://n2.nabble.com/git-compile-error-on-AIX-tp1499908p1499908.html
Sent from the git mailing list archive at Nabble.com.
