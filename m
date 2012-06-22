From: lalebarde <l.alebarde@free.fr>
Subject: Are non regression tests available ?
Date: Fri, 22 Jun 2012 02:17:44 -0700 (PDT)
Message-ID: <1340356664063-7561954.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 11:17:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shzzy-0003Aq-D7
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 11:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107Ab2FVJRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 05:17:45 -0400
Received: from sam.nabble.com ([216.139.236.26]:51808 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754714Ab2FVJRo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 05:17:44 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <l.alebarde@free.fr>)
	id 1Shzzs-0001GG-5o
	for git@vger.kernel.org; Fri, 22 Jun 2012 02:17:44 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200429>

Hi all,
Though the documentation of Git is very good, I remain puzzled on the
accurate workflow between /working/stagging/repository/ areas versus
/text/indent/filter/sha1/diff/ operations.
*Is there somewhere a set of non regression tests covering all Git
functionalities that would enable to see exactly what happens and what is
expected ?*

--
View this message in context: http://git.661346.n2.nabble.com/Are-non-regression-tests-available-tp7561954.html
Sent from the git mailing list archive at Nabble.com.
