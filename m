From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [GSoC 2010] The 5th week
Date: Sat, 26 Jun 2010 18:58:48 -0700
Message-ID: <AANLkTilnjaI5ynxITMse2Ie2-oPPCzr0OjL4vcXQUWFS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jun 27 03:59:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSh9A-00056Y-38
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 03:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798Ab0F0B6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 21:58:51 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63801 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007Ab0F0B6u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 21:58:50 -0400
Received: by qwi4 with SMTP id 4so1159061qwi.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 18:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=7zlCOLxvlAO8RvmaaxF+T+ZGqPVxtpVTxQBf5OD6avo=;
        b=CnlunZOGz+Gvjx5qHGdsX/t8N0bo03I4/qDHkF1+2SqUdaLyGbQe1qujCLZiMVUqDV
         kdEPq1PU75d3GSMC3ICyhPl9eDKYiBuO9wW9nw9hpHjbwAgyKTmJftYMTcK/TYXC2XCK
         RIefpVFc1en3qgEVemR/vSlF38OLrIHFZv6Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=jVlKnf+/miyoovZ+KBSS1qgwB0D6hAJSA+WBoi17kk1wMuRfa49HWUOZcekZbFBgb+
         FdLsxgRp8McuXl+aI6ZogogJEMqPSZ0Txym15szKeOvIoxnv8aOMLqH8mTN9YCFk+qaT
         /OH6mZ8u24RWqmb9FYg1syzEXGQwI4z30C+hE=
Received: by 10.224.74.194 with SMTP id v2mr1892956qaj.286.1277603928802; Sat, 
	26 Jun 2010 18:58:48 -0700 (PDT)
Received: by 10.229.98.70 with HTTP; Sat, 26 Jun 2010 18:58:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149785>

Hi,
    A simple weekly update of the project.

    This week is tesing and bug-fixing week. I have redesign some data
structure of the line level browser and fix several bugs/memory leaks
of it. As you seen, I have post the first series of patches to the
list and waiting for your comments. :)
    For the coming two weeks:
1. Follow the patch series issues;
2. Make --graph works well with line level history browser;
3. Parent rewriting

Thanks!

-- 
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
