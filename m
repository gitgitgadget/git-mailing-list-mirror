From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [ANNOUNCE] JGit 0.7.1 / EGit 0.7.1
Date: Mon, 29 Mar 2010 18:23:23 -0700
Message-ID: <20100330012323.GD32653@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 30 03:23:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwQB3-0002Kt-IK
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 03:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910Ab0C3BX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 21:23:28 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60891 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754737Ab0C3BX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 21:23:27 -0400
Received: by gwaa18 with SMTP id a18so4432970gwa.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 18:23:26 -0700 (PDT)
Received: by 10.100.17.26 with SMTP id 26mr7929383anq.149.1269912206442;
        Mon, 29 Mar 2010 18:23:26 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm4554301iwn.15.2010.03.29.18.23.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 18:23:25 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143532>

In mid-2009 the EGit and JGit projects started to move to the
Eclipse Foundation.  Last week both projects shipped version 0.7.1,
which is our first release since 0.5.0 in June 2009.

Many bugs have been fixed, included the dreaded push corruption bug.
But most of the release was us figuring out how to navigate the
Eclipse Foundation's processes, so there aren't many new features
relative to 0.5.0.


About JGit:

  JGit is a 100% pure-Java reimplementation of the Git version
  control system, licensed under a BSD style license.  These days it
  can be found embedded in quite a few software products.  Although
  the library development is now hosted by the Eclipse Foundation,
  it has no outside dependencies beyond the Java standard runtime,
  and the BSD licensed JSch SSH client library.

  * http://www.eclipse.org/jgit/
  * http://www.eclipse.org/jgit/download/


About EGit:

  EGit is an Eclipse Team Provider plugin, providing Git features
  directly within an Eclipse workspace.  It is built on top of the
  JGit library, making the plugin very portable.

  * http://www.eclipse.org/egit/
  * http://www.eclipse.org/egit/download/
  * http://download.eclipse.org/egit/updates

-- 
Shawn.
