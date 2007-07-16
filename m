From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Mon, 16 Jul 2007 19:55:06 +0200
Message-ID: <20070716175506.GE16780@cip.informatik.uni-erlangen.de>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de> <11846075213759-git-send-email-sithglan@stud.uni-erlangen.de> <20070716174239.GG19073@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Mon Jul 16 19:55:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAUmt-0008Em-5q
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 19:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbXGPRzI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 13:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbXGPRzI
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 13:55:08 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:47503 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751262AbXGPRzH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 13:55:07 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 7F2E93F434; Mon, 16 Jul 2007 19:55:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070716174239.GG19073@lavos.net>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52700>

Hallo Brian,

> You've got some whitespace damage here.  Git's style is to use tabs.

I have expandtab in my vim config which writes 8 spaces instead of tabs.
I should change that for git.

        Thomas
