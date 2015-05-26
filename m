From: John Lee <jjl@pobox.com>
Subject: Staging commits with visual diff tools?
Date: Tue, 26 May 2015 21:50:49 +0100 (BST)
Message-ID: <alpine.DEB.2.10.1505262147230.3709@alice>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 22:57:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxLue-0005oO-ND
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 22:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbbEZU5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 16:57:15 -0400
Received: from fallback-out2.mxes.net ([216.86.168.191]:63174 "EHLO
	fallback-in2.mxes.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751143AbbEZU5O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 16:57:14 -0400
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 May 2015 16:57:14 EDT
Received: from mxout-08.mxes.net (mxout-08.mxes.net [216.86.168.183])
	by fallback-in1.mxes.net (Postfix) with ESMTP id 2F9F92FD7E4
	for <git@vger.kernel.org>; Tue, 26 May 2015 16:50:58 -0400 (EDT)
Received: from alice.home (unknown [109.156.160.95])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTPSA id 03BA2509C3
	for <git@vger.kernel.org>; Tue, 26 May 2015 16:50:56 -0400 (EDT)
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269975>

Hi

Does anybody have code to stage commits using a the visual diff/merge 
tools supported by git-difftool?  Is there support in git itself 
somewhere, even?

I'm looking for something functionally similar to git add -p

Looking at the git-difftool source I can see how to write a command to do 
it, but wanted to check if it had already been implemented.

Did I miss a way that already exists?

Thanks


John
