From: "Sam Watkins" <swatkins@fastmail.fm>
Subject: git-push hook to update remote working copy safely
Date: Fri, 23 Feb 2007 19:51:49 +1100
Message-ID: <1172220709.10221.1176113191@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 23 09:50:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKW8B-0003we-Bu
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 09:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbXBWIuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 03:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbXBWIuP
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 03:50:15 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:39760 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932155AbXBWIuO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Feb 2007 03:50:14 -0500
Received: from out1.internal (unknown [10.202.2.149])
	by out1.messagingengine.com (Postfix) with ESMTP id 03A9C1CB420
	for <git@vger.kernel.org>; Fri, 23 Feb 2007 03:51:50 -0500 (EST)
Received: from web4.messagingengine.com ([10.202.2.213])
  by out1.internal (MEProxy); Fri, 23 Feb 2007 03:51:50 -0500
Received: by web4.messagingengine.com (Postfix, from userid 99)
	id D7A5615B718; Fri, 23 Feb 2007 03:51:49 -0500 (EST)
X-Sasl-Enc: 9ExyXoFkc5GZKmrEaarpNmUGLBGIbDbXSEis1tgR+O8t 1172220709
Content-Disposition: inline
X-Mailer: MessagingEngine.com Webmail Interface
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40430>

peace,

I'm looking for a command that will update the remote working copy after
a "git push", without damaging any changes that may have been made to
the working copy.
I haven't used git barely at all, hoping this is an okay place to ask
about this.  I can put the command into the push hook myself, I just
don't know what command does that!

This is one of the last "pieces" needed for a hopefully useful
application I'm working on with a friend, which uses git for storage and
file transfer.


Sam
