From: Peng Yu <pengyu.ut@gmail.com>
Subject: How to change the index for git status?
Date: Sat, 4 Feb 2012 14:06:28 -0600
Message-ID: <CABrM6wm2MochqgC0+FByDA-6nmo0XHtZy1FDXJRkc30+2eyiTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 21:06:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtlsX-0003J0-MW
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 21:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390Ab2BDUG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 15:06:29 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33326 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432Ab2BDUG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 15:06:28 -0500
Received: by iacb35 with SMTP id b35so6441310iac.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 12:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=iHyaVDtY91kO0dr2/6AJae/FUBZnnT7F4HpgDvyMTiY=;
        b=VtcNrPoMtTTYtYHvtuJ6YaACsrdAA03HnGHMxEFTtKnvoV7YrF7wIN7JCwaeQyt9Qr
         ghAXe11GBKNvQTclTn4piBpDLw4dK36mhjF/dOC27cqa7Fbnkd+dR+co6gT08x5Cg2hB
         4f18mdBS82+u4e0ySClbUuGGV3gcFe0qZkFBw=
Received: by 10.42.165.135 with SMTP id k7mr13402404icy.32.1328385988488; Sat,
 04 Feb 2012 12:06:28 -0800 (PST)
Received: by 10.50.111.6 with HTTP; Sat, 4 Feb 2012 12:06:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189901>

Hi,

When I run git status, it show the status compared against the branch
upstream/develop. I want it to compare against origin/develop. I
checked progit. But I don't see how to change the branch to compare
to. Could anybody let me know how to do so? Thanks!

~/dvcs_src/craftyjs1/Crafty/build/api$ git status
# On branch 2D_doc_dev
# Your branch is ahead of 'upstream/develop' by 2 commits.
#
nothing to commit (working directory clean)


-- 
Regards,
Peng
