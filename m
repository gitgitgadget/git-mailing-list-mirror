From: bain <bain@devslashzero.com>
Subject: git-commit does not signoff using name supplied by --author
Date: Fri, 17 Oct 2008 03:11:55 -0700 (PDT)
Message-ID: <6a7ddf4e-8fcb-4a39-b4c5-1396cf702c8b@f40g2000pri.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 17 12:13:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqmKT-0003re-NN
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 12:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbYJQKL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 06:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbYJQKL5
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 06:11:57 -0400
Received: from yw-out-2122.google.com ([74.125.46.27]:5302 "EHLO
	yw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbYJQKL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 06:11:57 -0400
Received: by yw-out-2122.google.com with SMTP id 4so752790ywd.1
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 03:11:55 -0700 (PDT)
Received: by 10.100.58.19 with SMTP id g19mr50318ana.23.1224238315137; Fri, 17 
	Oct 2008 03:11:55 -0700 (PDT)
X-IP: 203.193.154.151
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.1) 
	Gecko/2008070206 Firefox/3.0.1,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98468>

Hi all,

If i use git-commit --author "A U Thor <author.example.net>" -s it
still uses my global author.name and author.email to add signoff
message.

Is this expected behavior?


thanks
BAIN
