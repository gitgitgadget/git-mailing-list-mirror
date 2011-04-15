From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: (Small) projects for students
Date: Fri, 15 Apr 2011 19:31:45 +0200
Message-ID: <vpqmxjra0am.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 19:35:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAmvI-0006bC-Aq
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 19:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726Ab1DORfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 13:35:03 -0400
Received: from imag.imag.fr ([129.88.30.1]:49212 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264Ab1DORfC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 13:35:02 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p3FHVjPK019378
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 15 Apr 2011 19:31:45 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QAmrx-0001DK-KS; Fri, 15 Apr 2011 19:31:45 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 15 Apr 2011 19:31:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171621>

Hi,

Last year, I proposed to my students (in Ensimag) to contribute to Git
as part of a school project. The students implemented nicer error
messages when "git checkout/pull/others" have conflicts between
untracked files and tracked files, and the textconv feature in "git
blame" and "git gui blame".

Last year, I asked the students to chose themselves the feature they
wanted to implement, but it didn't work very well, students didn't have
many ideas, and SoC projects were too big.

To prepare this year's project, I created a wiki page listing ideas of
projects they could implement:

  https://git.wiki.kernel.org/index.php/SmallProjectsIdeas

Your comments, and idea suggestions, are welcome.

Regards,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
