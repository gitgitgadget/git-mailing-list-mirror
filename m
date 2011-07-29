From: llucianf <llucianf@gmail.com>
Subject: Re: gitignore design
Date: Fri, 29 Jul 2011 05:01:17 -0700 (PDT)
Message-ID: <1311940877783-6633274.post@n2.nabble.com>
References: <1311934832699-6632987.post@n2.nabble.com> <4E329EDB.6040007@hupie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 14:01:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qmlkt-00018N-63
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 14:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228Ab1G2MBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 08:01:19 -0400
Received: from sam.nabble.com ([216.139.236.26]:57629 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756209Ab1G2MBS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 08:01:18 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <llucianf@gmail.com>)
	id 1Qmlkj-0004mq-Pf
	for git@vger.kernel.org; Fri, 29 Jul 2011 05:01:17 -0700
In-Reply-To: <4E329EDB.6040007@hupie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178139>

sorry but this is not always the case. there are plenty of cases (project
files is most common example) in which i need files in repo but i do not
need git to track them. so why i cant just simply enumerate those project
files into .gitignore and 'persuade'  git to simply forget about them?


--
View this message in context: http://git.661346.n2.nabble.com/gitignore-design-tp6632987p6633274.html
Sent from the git mailing list archive at Nabble.com.
