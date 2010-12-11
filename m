From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: add the equivalent of diff --color-words
Date: Sun, 12 Dec 2010 10:48:24 +1100
Message-ID: <20101211234824.GE3788@brick.ozlabs.ibm.com>
References: <3c06517d478b3725054f4ca08fb8c38e681549c4.1287223650.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Dec 12 04:30:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRcdQ-0001hI-6U
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 04:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565Ab0LLD3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Dec 2010 22:29:43 -0500
Received: from ozlabs.org ([203.10.76.45]:53061 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752248Ab0LLD3n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Dec 2010 22:29:43 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id DA4BEB70A7; Sun, 12 Dec 2010 14:29:41 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <3c06517d478b3725054f4ca08fb8c38e681549c4.1287223650.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163466>

On Sat, Oct 16, 2010 at 12:15:10PM +0200, Thomas Rast wrote:

> Use the newly added 'diff --word-diff=porcelain' to teach gitk a
> color-words mode, with two different modes analogous to the
> --word-diff=plain and --word-diff=color settings.  These are selected
> by a dropdown box.

Thanks, applied.

Paul.
