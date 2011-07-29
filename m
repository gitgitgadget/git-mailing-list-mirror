From: llucianf <llucianf@gmail.com>
Subject: Re: gitignore design
Date: Fri, 29 Jul 2011 05:44:41 -0700 (PDT)
Message-ID: <1311943481799-6633412.post@n2.nabble.com>
References: <1311934832699-6632987.post@n2.nabble.com> <4E329EDB.6040007@hupie.com> <1311940877783-6633274.post@n2.nabble.com> <4E32A2D2.9060007@hupie.com> <1311941774976-6633332.post@n2.nabble.com> <m3y5zhqnlv.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 14:44:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmmQp-0004nE-QT
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 14:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756282Ab1G2Mon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 08:44:43 -0400
Received: from sam.nabble.com ([216.139.236.26]:47014 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755975Ab1G2Mom (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 08:44:42 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <llucianf@gmail.com>)
	id 1QmmQj-0008Vk-QB
	for git@vger.kernel.org; Fri, 29 Jul 2011 05:44:41 -0700
In-Reply-To: <m3y5zhqnlv.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178144>

im sure cvs doesnt require you to remove files from repo in order to ignore
them. i used cvs for years and its ingonre policy is simple and effective.
you just put the files/patterns into ignore file and things happen aka they
are ignored.
with this very intelligent git this simple thing is not so simple. of course
there are workarounds (like the template example you gave) but they are
clumsy.
im just trying to understand why git ignore mechanism cant just read the
.gitignore file and obey to those ignore rules without asking you to do
fancy voodoo operations such removing those files from repo.


--
View this message in context: http://git.661346.n2.nabble.com/gitignore-design-tp6632987p6633412.html
Sent from the git mailing list archive at Nabble.com.
