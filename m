From: supadhyay <supadhyay@imany.com>
Subject: User authentication in GIT
Date: Mon, 6 Feb 2012 22:12:09 -0800 (PST)
Message-ID: <1328595129258-7261349.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 07:12:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RueHm-0008G4-Su
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 07:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222Ab2BGGMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 01:12:10 -0500
Received: from sam.nabble.com ([216.139.236.26]:39443 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754062Ab2BGGMK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 01:12:10 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <supadhyay@imany.com>)
	id 1RueHh-00041M-8b
	for git@vger.kernel.org; Mon, 06 Feb 2012 22:12:09 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190144>

Hi All,

I want to migrate my existing version control system (CVS) into GIT. The
first question which comes to me is in CVS we have user authentication like
username and their password while in GIT there is SSH authentication. 

Can any one suggest me what is the optimal way to manage the users in GIT?
Does all users having username,passowrd and SSH key? or thre is no users
credential but only SSH authentication? if I have 1000 users in old system
CVS then do I need to create a key for all 1000 users in GIT? or etc.


Thanks in advance...

--
View this message in context: http://git.661346.n2.nabble.com/User-authentication-in-GIT-tp7261349p7261349.html
Sent from the git mailing list archive at Nabble.com.
