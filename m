From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: Solaris test failure for git-1.5.4.4 -- t0021-conversion.sh
Date: Tue, 11 Mar 2008 09:55:38 -0700 (PDT)
Message-ID: <alpine.DEB.1.00.0803110954360.4428@alchemy.localdomain>
References: <8ec76080803110533m14041aebhc779d117a5bb6112@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 17:56:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ7m6-00036S-Of
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 17:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbYCKQzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 12:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbYCKQzr
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 12:55:47 -0400
Received: from wide-rose.makesad.us ([203.178.130.147]:58004 "EHLO
	rose.makesad.us" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751480AbYCKQzr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 12:55:47 -0400
Received: from alchemy (localhost [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rose.makesad.us (Postfix) with ESMTP id D6D2A3342DD;
	Tue, 11 Mar 2008 12:55:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by alchemy (Postfix) with ESMTP id A59C26EAC8;
	Tue, 11 Mar 2008 09:55:38 -0700 (PDT)
X-X-Sender: paulproteus@alchemy.localdomain
In-Reply-To: <8ec76080803110533m14041aebhc779d117a5bb6112@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76880>

On Tue, 11 Mar 2008, Whit Armstrong wrote:

> xs5-trd-p1.grn:warmstro> sh t0021-conversion.sh -i -v

Try running this as "sh -x t0021-conversion.sh -i -v".  That will print 
the exact commands run just before they are run, letting you figure 
out what tr is complaining about.

-- Asheesh.

-- 
I know what "custody" [of the children] means.  "Get even."  That's all
custody means.  Get even with your old lady.
 		-- Lenny Bruce
