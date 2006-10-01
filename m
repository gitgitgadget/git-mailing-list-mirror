From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: ANSWER
Date: Sun, 1 Oct 2006 12:53:02 +0100
Message-ID: <200610011253.03169.alan@chandlerfamily.org.uk>
References: <200610011138.06823.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Oct 01 13:53:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTzsc-0003Xq-AF
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 13:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWJALw5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 07:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWJALw4
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 07:52:56 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:56476
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S932082AbWJALw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Oct 2006 07:52:56 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.63)
	(envelope-from <alan@chandlerfamily.org.uk>)
	id 1GTzsN-000757-5J
	for git@vger.kernel.org; Sun, 01 Oct 2006 12:52:55 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.9.4
In-Reply-To: <200610011138.06823.alan@chandlerfamily.org.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28177>

On Sunday 01 October 2006 11:38, Alan Chandler wrote:

> I have a .git/remotes/public file which contains
>
> URL:roo.home:/var/lib/git/akclib.git
> Push:master

The URL: and Push: need spaces before the detail

This used to work, so somewhere along the line (when the builtin was 
introduced?) the need for the space has arisen.

The documentation, although showing the space is not very clear about it.

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
