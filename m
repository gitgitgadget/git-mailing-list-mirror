From: Grant <emailgrant@gmail.com>
Subject: Does git have "Path-Based Authorization"?
Date: Fri, 30 Sep 2011 16:43:28 -0700
Message-ID: <CAN0CFw0QXkNSF8+qGu+pCrv5dgy1OEvtq-53f23GRd4RrZ1GcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 01:43:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9mju-0002AD-GX
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 01:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023Ab1I3Xnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 19:43:31 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55105 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279Ab1I3Xn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 19:43:29 -0400
Received: by eya28 with SMTP id 28so1500359eya.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 16:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=NrHhPeXVC20wXcPkkOq1DouQ/HFh/ayFqGhgJtnO0Fw=;
        b=j1jOacir1nZeYGAvze7ROq0oHj+uFjLrT82+0d64uVRBwwYBPYMYSEwkiXhfbVs5YJ
         4WzmhGoaeFcatl36HgPI/kmM4VtTFL0Jq9D0L75pJeq3UVueTlyu6UgjOpPaBPfpYEzR
         0Qiyzg+QkxB3VlJDMVHvl4KySv0tA7d7vvby4=
Received: by 10.213.19.20 with SMTP id y20mr80864eba.27.1317426208191; Fri, 30
 Sep 2011 16:43:28 -0700 (PDT)
Received: by 10.213.4.136 with HTTP; Fri, 30 Sep 2011 16:43:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182525>

Hello, I'm trying to decide between git and subversion.  Subversion
has "Path-Based Authorization" so I can give a developer access to
only specific files instead of everything.  Does git have something
similar?

http://svnbook.red-bean.com/en/1.5/svn.serverconfig.pathbasedauthz.html

- Grant
