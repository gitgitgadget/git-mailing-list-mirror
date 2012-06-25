From: guruprasad <guruprasadkinI@gmail.com>
Subject: Urgent: Issue with GIT ...
Date: Mon, 25 Jun 2012 04:49:40 -0700 (PDT)
Message-ID: <1340624980925-7562097.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 13:49:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj7nd-0004JY-Tz
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 13:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114Ab2FYLtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 07:49:42 -0400
Received: from sam.nabble.com ([216.139.236.26]:52286 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755979Ab2FYLtl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 07:49:41 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <guruprasadkinI@gmail.com>)
	id 1Sj7nY-0004Xi-Uc
	for git@vger.kernel.org; Mon, 25 Jun 2012 04:49:40 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200572>

Hi,

I am Guruprasad from Bangalore, India working for HP. I am very much new to
git and trying to establish a DVCS in my workstation. I am facing few
problems please help me out. below i am giving my setup and the things i
have done till now.

1) I have 2 Linux box (A and B). GIT installed in both of them.
2) I have one project in A and added to GIT repository.
3) Cloned A repository into B. Complete repository got cloned into B from A
along with all source code.
4) If I do some changes to files in A and commit, I am able to pull the
changes done and merge into B. (here i am not doing any push, just pull is
getting all updates)
5) If i do some changes to files in B, commit and push to remote branch, I
am unable to pull the changes done and merge into A. I have set
"receive.denycurrentbranch=ignore" in git config.

Can you please tel me where i am going wrong. Do I need to set anything in
git config?

Once this test is done I need to implement patches over email by using JGIT
in my application, please point me to some nice pointers so that i can
implement it in Java. Please help in this as well.

Quick response is very much appreciated.

Regards,
Guruprasad


--
View this message in context: http://git.661346.n2.nabble.com/Urgent-Issue-with-GIT-tp7562097.html
Sent from the git mailing list archive at Nabble.com.
