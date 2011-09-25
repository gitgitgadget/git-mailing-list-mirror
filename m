From: vra5107 <venkatram.akkineni@gmail.com>
Subject: Can a git changeset be created with no parent
Date: Sun, 25 Sep 2011 07:15:36 -0700 (PDT)
Message-ID: <1316960136073-6829212.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 16:15:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7pUb-000637-3e
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 16:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812Ab1IYOPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Sep 2011 10:15:37 -0400
Received: from sam.nabble.com ([216.139.236.26]:52517 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752794Ab1IYOPg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2011 10:15:36 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <venkatram.akkineni@gmail.com>)
	id 1R7pUW-0001qO-2b
	for git@vger.kernel.org; Sun, 25 Sep 2011 07:15:36 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182075>

Hi

        I am currently in the process of converting a large hg repository.
One of the changesets has no parents assigned. So to mirror that is it
possible to create a git changeset that doesnot have a parent ?

Thanks
Venkat

--
View this message in context: http://git.661346.n2.nabble.com/Can-a-git-changeset-be-created-with-no-parent-tp6829212p6829212.html
Sent from the git mailing list archive at Nabble.com.
