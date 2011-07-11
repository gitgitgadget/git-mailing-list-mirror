From: frankkany <frankkany@gmail.com>
Subject: Re: git remote show origin (URL)
Date: Mon, 11 Jul 2011 10:42:59 -0700 (PDT)
Message-ID: <1310406179881-6571875.post@n2.nabble.com>
References: <1310400505376-6571492.post@n2.nabble.com> <m239ic3f01.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 19:43:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgKVg-0006h2-Pg
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 19:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758325Ab1GKRnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 13:43:01 -0400
Received: from sam.nabble.com ([216.139.236.26]:37285 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758287Ab1GKRnA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 13:43:00 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <frankkany@gmail.com>)
	id 1QgKVX-0007NS-Sl
	for git@vger.kernel.org; Mon, 11 Jul 2011 10:42:59 -0700
In-Reply-To: <m239ic3f01.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176878>

I appreciate everyone's help.  Ilya Bobyr's suggestion worked.  As Ilya
suggested, it was defined in my ssh_config file.

=========================================
There might be a "Host hidden-repos" entry in your .ssh/config or
/etc/ssh_config that maps the name to the actual hostname.

Ilya Bobyr

--
View this message in context: http://git.661346.n2.nabble.com/git-remote-show-origin-URL-tp6571492p6571875.html
Sent from the git mailing list archive at Nabble.com.
