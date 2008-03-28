From: =?utf-8?B?UmFmYcWCIE11xbx5xYJv?= <galtgendo@o2.pl>
Subject: Git vs svn. Is ... possible ?
Date: Fri, 28 Mar 2008 14:24:38 +0100
Message-ID: <20080328132438.GA32646@blackspire>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 14:25:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfEaW-0006vx-UY
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 14:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbYC1NYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 09:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753894AbYC1NYy
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 09:24:54 -0400
Received: from tur.go2.pl ([193.17.41.50]:45570 "EHLO tur.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbYC1NYx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 09:24:53 -0400
Received: from poczta.o2.pl (mx12.go2.pl [193.17.41.142])
	by tur.go2.pl (o2.pl Mailer 2.0.1) with ESMTP id 5EEBC230560
	for <git@vger.kernel.org>; Fri, 28 Mar 2008 14:24:51 +0100 (CET)
Received: from poczta.o2.pl (mx12 [127.0.0.1])
	by poczta.o2.pl (Postfix) with ESMTP id 1A6223E805C
	for <git@vger.kernel.org>; Fri, 28 Mar 2008 14:23:19 +0100 (CET)
Received: from localhost (host-89-228-42-12.elk.mm.pl [89.228.42.12])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by poczta.o2.pl (Postfix) with ESMTP
	for <git@vger.kernel.org>; Fri, 28 Mar 2008 14:23:18 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78406>

Well, the actual question is:
In svn I can do a remote diff (diff between two remote revisions) without
having to do a checkout, is this possible for git ?
