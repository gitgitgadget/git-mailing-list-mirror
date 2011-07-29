From: llucianf <llucianf@gmail.com>
Subject: gitignore design
Date: Fri, 29 Jul 2011 03:20:32 -0700 (PDT)
Message-ID: <1311934832699-6632987.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 12:20:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmkBO-0007o1-60
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 12:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755969Ab1G2KUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 06:20:33 -0400
Received: from sam.nabble.com ([216.139.236.26]:55737 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755841Ab1G2KUd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 06:20:33 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <llucianf@gmail.com>)
	id 1QmkBE-00051q-Mv
	for git@vger.kernel.org; Fri, 29 Jul 2011 03:20:32 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178130>

why gitignore doesnt simply work like in cvs where if you put something in
the ignore file, those stuff are simply ignored from that point without
having to remove them from repo?


--
View this message in context: http://git.661346.n2.nabble.com/gitignore-design-tp6632987p6632987.html
Sent from the git mailing list archive at Nabble.com.
