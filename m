From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: problem with Documentation/hooks.txt
Date: Sun, 7 Jan 2007 11:13:51 +0000
Message-ID: <200701071113.51597.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jan 07 12:13:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3VyP-0000ND-Tn
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 12:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbXAGLNz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 06:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbXAGLNz
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 06:13:55 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:35772
	"EHLO home.chandlerfamily.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932497AbXAGLNy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jan 2007 06:13:54 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.63)
	(envelope-from <alan@chandlerfamily.org.uk>)
	id 1H3VyL-0003ZT-Ii
	for git@vger.kernel.org; Sun, 07 Jan 2007 11:13:53 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36155>

I was just looking at the documentation of the post-commit hook in order 
to fix a problem on one of my repositories and I came across this:-

"The default 'post-commit' hook, when enabled, demonstrates how to
send out a commit notification e-mail."

So I went looking in the templates/hooks--post-commit file and it has 
nothing (literally :-) ).

and as far as I can see looking over git's history it has always been 
like that.

I don't have an example to submit a patch - but I am sure lots of people 
have done something like that and could provide one.


-- 
Alan Chandler
http://www.chandlerfamily.org.uk
