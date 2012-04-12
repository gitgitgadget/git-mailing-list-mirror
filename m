From: cvalusek <clintv2@gmail.com>
Subject: Re: GIT pull
Date: Thu, 12 Apr 2012 10:29:03 -0700 (PDT)
Message-ID: <1334251743350-7460163.post@n2.nabble.com>
References: <1334242077960-7459655.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 12 19:29:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SINpY-00061q-5r
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 19:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760873Ab2DLR3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 13:29:06 -0400
Received: from sam.nabble.com ([216.139.236.26]:53408 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757772Ab2DLR3F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 13:29:05 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <clintv2@gmail.com>)
	id 1SINpP-0001cK-Bd
	for git@vger.kernel.org; Thu, 12 Apr 2012 10:29:03 -0700
In-Reply-To: <1334242077960-7459655.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195348>

Looks like it's the virus scan. I had this e-mail that I accidentally sent to
Michael directly instead of the list:

I will see if I can build a script that reproduces the issue we are seeing. 

We are starting to speculate about what is going on now. Maybe our virus
scan is causing some git operation to fail in the middle of the merge.

The "terrible state" is a half-way applied merge.

--
View this message in context: http://git.661346.n2.nabble.com/GIT-pull-tp7459655p7460163.html
Sent from the git mailing list archive at Nabble.com.
