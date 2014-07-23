From: Gaffney <ryanmgaffney@gmail.com>
Subject: Re: [PATCH/RFC] git-svn: New flag to add a file in empty
 directories
Date: Tue, 22 Jul 2014 17:06:37 -0700 (PDT)
Message-ID: <1406073997070-7615634.post@n2.nabble.com>
References: <1305669635-10861-1-git-send-email-rchen@cs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 02:06:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9k4v-0008AC-Ns
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 02:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757281AbaGWAGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 20:06:38 -0400
Received: from sam.nabble.com ([216.139.236.26]:49911 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756914AbaGWAGh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 20:06:37 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <ryanmgaffney@gmail.com>)
	id 1X9k4r-00076b-2X
	for git@vger.kernel.org; Tue, 22 Jul 2014 17:06:37 -0700
In-Reply-To: <1305669635-10861-1-git-send-email-rchen@cs.umd.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254053>

Any idea why this parameter would slow down a clone so severely?  I am
experiencing clone slowdown by 5x+ after adding this parameter, which is not
cool given the size of the repository and the urgency of finishing the
migration.



--
View this message in context: http://git.661346.n2.nabble.com/PATCH-RFC-git-svn-New-flag-to-add-a-file-in-empty-directories-tp6375393p7615634.html
Sent from the git mailing list archive at Nabble.com.
