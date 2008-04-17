From: Dill <sarpulhu@gmail.com>
Subject: Git GUI bug?
Date: Wed, 16 Apr 2008 22:52:56 -0700 (PDT)
Message-ID: <7e6dd49b-133d-4b71-96bd-d1ca0357aa15@b1g2000hsg.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 07:53:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmN43-0005Up-2n
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 07:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbYDQFw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 01:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbYDQFw6
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 01:52:58 -0400
Received: from ag-out-0910.google.com ([72.14.246.185]:55899 "EHLO
	ag-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbYDQFw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 01:52:58 -0400
Received: by ag-out-0910.google.com with SMTP id 40so5821836agd.1
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 22:52:56 -0700 (PDT)
Received: by 10.100.206.11 with SMTP id d11mr48156ang.23.1208411576753; Wed, 
	16 Apr 2008 22:52:56 -0700 (PDT)
X-IP: 161.184.182.37
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) 
	Gecko/20080404 Firefox/2.0.0.14,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79768>

When trying to push a repo using git gui to Github it opens a new
window saying pushing branch and working....please wait...Push works
if I do it by command line and I think the bug may be related to
public/private keys? Git GUI never asks for a password for when I
upload the repo. Am I doing something wrong? (When I click sign off in
Git gui it shows the correct name). I'm using msysGit 1.5.5. Thanks.
