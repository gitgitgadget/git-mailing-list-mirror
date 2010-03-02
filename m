From: "Kovacs, Levente" <leventelist@gmail.com>
Subject: split up a repository
Date: Tue, 2 Mar 2010 01:12:26 +0100
Message-ID: <20100302011226.76fda85d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 02 01:19:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmFpd-00081b-7r
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 01:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651Ab0CBATU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 19:19:20 -0500
Received: from mail-xsmtp1.externet.hu ([212.40.96.152]:50762 "EHLO
	mail-xsmtp1.externet.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263Ab0CBATT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 19:19:19 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Mar 2010 19:19:19 EST
Received: (qmail 17202 invoked from network); 2 Mar 2010 00:12:37 -0000
Received: from fxip-006cc.externet.hu (HELO mail.logonex.eu) (?@92.52.216.204)
  by 0 with ESMTP; 2 Mar 2010 00:12:37 -0000
Received: from localhost.localdomain (rumba.levalinux.org [192.168.1.10])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.logonex.eu (Postfix) with ESMTPS id B0FA814AB52
	for <git@vger.kernel.org>; Tue,  2 Mar 2010 01:12:36 +0100 (CET)
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.18.7; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141369>

Hi all,


Ok, I *WAS* an SVN user, so forgive my ignorance. I have successfully
migrated from SVN to git. However, I had only one repository under my
SVN server, which is not a good approach with git.

http://logonex.eu/git/?p=svn.git;a=summary

Now I have one git repository, which I'd like to split up to several others. Does it possible with git? If it is, how?

How can I split up a single repo to several others? It would be nice to
keep the history.

Thank you for your help in advance.

Levente
