From: "Jim Vahl" <jv@wmdb.com>
Subject: A basic question
Date: Wed, 10 Oct 2012 11:03:23 -0700
Message-ID: <001501cda711$8ab6f0a0$a024d1e0$@com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Skot Davis'" <skotd122@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 20:03:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM0d7-0002if-Dl
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 20:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756334Ab2JJSD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 14:03:26 -0400
Received: from 339272-web1.sleeplessmedia.com ([72.32.211.234]:47963 "EHLO
	339272-web1.sleeplessmedia.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755810Ab2JJSD0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2012 14:03:26 -0400
Received: (qmail 9243 invoked from network); 10 Oct 2012 13:03:25 -0500
Received: from 173-167-120-98-sfba.hfc.comcastbusiness.net (HELO Sequoia) (173.167.120.98)
  by 192.168.100.234 with SMTP; 10 Oct 2012 13:03:24 -0500
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: Ac2nEYoSkElW0Dh5T4iYoat93lN11A==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207421>

All,

Our company is researching version control software, something which we have
not used previously.  I have a very basic question about git which I have
not been able to answer from reading.  As I understand it, a git repository
can be a mixture of files which are under development, staged or committed.
If we make a new build of our product we will obviously only want to include
the committed (tested) files.  

The question is this: what is the usual procedure to retrieve a set of
committed  files only from the repository to place into a distribution or
"ready to build" folder.  The same question goes for tagging a release: how
does the user get the tag to reference the committed files only and not the
most recent files which may be under development or undergoing testing.

Thanks,

Jim Vahl
