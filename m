From: Frank Li <lznuaa@gmail.com>
Subject: [ANNOUNCE] TortoiseGit 1.3.6.0 Release
Date: Tue, 9 Feb 2010 13:58:36 +0800
Message-ID: <1976ea661002082158ic46e7c8nce16f958754bad8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: tortoisegit-dev <tortoisegit-dev@googlegroups.com>,
	tortoisegit-announce@googlegroups.com,
	tortoisegit-users@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 06:58:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nej7T-0008CV-IV
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 06:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938Ab0BIF6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 00:58:38 -0500
Received: from mail-yx0-f193.google.com ([209.85.210.193]:49919 "EHLO
	mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab0BIF6h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 00:58:37 -0500
Received: by yxe31 with SMTP id 31so6478799yxe.21
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 21:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=CSl9qrZXPuHjqlbqSAONcgZbMUsLUFksBgZXnCc8AZY=;
        b=dECHtv3UL0+wv4Can24AOzqiAQX7vAv6XJC/FKAi54xwx6B+o/EQL0o7Mi+UgMf1ub
         Se83Jpg4c2dX+Qo+u7UIA9WrIzUizui5y4qvpYiLTKW+rqGmxs+TCll2F5VqxVoK0d/I
         qV4gZbquBwPwdZuGRVQJTqTVszrN3GggAPo6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=hkm18Snbb78sc6H6ibyjO8mmFnpJYS1PS1VrmEwguQNYA23nsYA5hy9SXnvN/SpN61
         2yPw3j27SSwT3OMbgzqA0nuEDUZ+V/7Gd5Et9NNnNg64U48OtH9c4/RaLZnC52bW+I4m
         3uckxDaIQKHhvuXZ41q75QNply+beZdik6yTc=
Received: by 10.150.55.31 with SMTP id d31mr2815819yba.327.1265695116851; Mon, 
	08 Feb 2010 21:58:36 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139370>

Download:

http://tortoisegit.googlecode.com/files/TortoiseGit-1.3.6.0-32bit.msi

http://tortoisegit.googlecode.com/files/TortoiseGit-1.3.6.0-64bit.msi

= Release 1.3.6.0 =
== Bug Fix ==
 * Fixed log crash when no body message at commit
 * Fixed issue #298: State of "View Patch/Hide Patch" link (commit
window) is wrong in some ways
 * Fixed issue #301: Show Log crashes with empty repo

= Release 1.3.5.0 =
== Features ==
 * Support Annotated tags
   Implemented issue #274: Enhancement: Annotated tags

 * shallow clones support --depth at clone dialog
   Fixed issue #290: Shallow clones support --depth at clone dialog

 * Improve Diff Dialog
   Change commit at diff dialog
   Diff commit context menu show in git repository

 * Log Dialog
   Direct Launch external diff when open dialog at file
   Log can refresh when Click Rev button.

 * Context menu
   Use setting dialog to control which menuitem is external menu.

 * Sync Dialog
   Add remote update at sync dialog

== Bug Fix ==
 * Fixed issue #294: commit template not supported and support msysgit unix path
 * Fixed issue #282: Fom/To/Messages/Authors/Paths filters are
eventually disabled
 * Fixed issue #292: Very large dialog when merging
 * Fixed issue #291: Blame makes empty "UserImages.bmp" file
 * Fix crash when copy several log message to clipboards
 * Fixed issue #284: Show Log crashes when switching branches wait for
log thread exit
 * Fixed issue #285: Cherry picking no longer works
 * Fix fetch command can't sync remote branch at sync dialog
