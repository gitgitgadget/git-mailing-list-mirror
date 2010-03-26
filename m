From: Simon Braunschmidt <sb@emlix.com>
Subject: request for enhancement: gitk highlight whitespace
Date: Fri, 26 Mar 2010 15:19:17 +0100
Organization: emlix gmbh, Goettingen, Germany
Message-ID: <201003261519.18095.sbraun@emlix.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Simon Braunschmidt <sb@emlix.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 16:06:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvB75-0004rE-3Z
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 16:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107Ab0CZPGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 11:06:14 -0400
Received: from mx1.emlix.com ([193.175.82.87]:44924 "EHLO mx1.emlix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753639Ab0CZPGN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 11:06:13 -0400
X-Greylist: delayed 2814 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Mar 2010 11:06:13 EDT
Received: from gate.emlix.com ([193.175.27.217]:55379 helo=mailer.emlix.com)
	by mx1.emlix.com with esmtp (Exim 4.69)
	(envelope-from <sb@emlix.com>)
	id 1NvANa-0003a2-AA
	for git@vger.kernel.org; Fri, 26 Mar 2010 15:19:18 +0100
Received: by mailer.emlix.com
	id 1NvANZ-0002M9-Vv; Fri, 26 Mar 2010 15:19:18 +0100
User-Agent: KMail/1.11.2 (Linux/2.6.32-020632rc6-generic; KDE/4.2.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143236>

Hi

It would be great if I could teach gitk to better highlight 
whitespace changes in the diff view.

Every once in a while (and again today) I have to review 
patches that "fix whitespace". Allthough the fixes are usually 
trivial, I have to check them, which is not trivial with the gitk 
display. Also I often mistakenly accept changes after 
review with gitk that turn out to contain a mix of 
tabs/whitespace etc. 

I searched the mailinglist (for gitk whitespace) and asked on irc, yet 
nobody seemed to care so far.

What do you think about it?

Regards,Gruessle
Simon
