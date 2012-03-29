From: anjibman <anjibcs@hotmail.com>
Subject: Index area concept and blowing it up
Date: Wed, 28 Mar 2012 19:11:04 -0700 (PDT)
Message-ID: <1332987064083-7416124.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 04:11:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD4pT-0003DY-Ju
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 04:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932903Ab2C2CLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 22:11:06 -0400
Received: from sam.nabble.com ([216.139.236.26]:51640 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932696Ab2C2CLE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 22:11:04 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <anjibcs@hotmail.com>)
	id 1SD4pM-0003NR-4U
	for git@vger.kernel.org; Wed, 28 Mar 2012 19:11:04 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194222>

Hi All,

My first question is where is this index actually in Git. Is that a some
folder or some location?

Second, how really Git keep information about index?

Third, in git community book it says " If you blow the index away entirely,
you generally haven't lost any information as long as you have the name of
the tree that it described". I didn't get this statement can any one explain
this in simple words.

And finally why git add is used for both adding untrack file as well as to
move file to stage area? Is there any particular reason for this?

Thanks,
Anjib 



--
View this message in context: http://git.661346.n2.nabble.com/Index-area-concept-and-blowing-it-up-tp7416124p7416124.html
Sent from the git mailing list archive at Nabble.com.
