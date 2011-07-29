From: llucianf <llucianf@gmail.com>
Subject: Re: gitignore design
Date: Fri, 29 Jul 2011 05:16:14 -0700 (PDT)
Message-ID: <1311941774976-6633332.post@n2.nabble.com>
References: <1311934832699-6632987.post@n2.nabble.com> <4E329EDB.6040007@hupie.com> <1311940877783-6633274.post@n2.nabble.com> <4E32A2D2.9060007@hupie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 14:16:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmlzI-00082s-IR
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 14:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866Ab1G2MQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 08:16:16 -0400
Received: from sam.nabble.com ([216.139.236.26]:40594 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755647Ab1G2MQP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 08:16:15 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <llucianf@gmail.com>)
	id 1QmlzC-0006Sf-Vk
	for git@vger.kernel.org; Fri, 29 Jul 2011 05:16:14 -0700
In-Reply-To: <4E32A2D2.9060007@hupie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178141>

is not a contradiction. i need project files into repo so whenever i clone
the project on diff machine i need them there.
but during development i dont need them to be 'taken into account' by git. 
the purpose of this topic is for me to understand why git dont use the
simple cvs approach on this matter.
why i cant just enumerate some files into .gitignore file and have git
simply ignore them without removing them from repo?

--
View this message in context: http://git.661346.n2.nabble.com/gitignore-design-tp6632987p6633332.html
Sent from the git mailing list archive at Nabble.com.
