From: JuanPablo AJ <jpabloaj@gmail.com>
Subject: add remote branch permanently
Date: Sun, 7 Aug 2011 15:44:57 -0400
Message-ID: <CAN8859Q2idRVbWSrjx3KX8FyhpN-KFcRRqAS0v8LaBrYnb0gCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 21:48:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq9Kg-0000Rj-Kp
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 21:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741Ab1HGTo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 15:44:58 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:43776 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440Ab1HGTo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 15:44:58 -0400
Received: by iye16 with SMTP id 16so7578779iye.1
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 12:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=VDz57sKOwfJXtUkUl5jbIyXFA0uNOD3lso+8uGNktcs=;
        b=I5K6Tw44pfpctZsr9U6BM/oEko0N5w6ym3WQfdWOA+fifB139GaS8Qp0uMqSq8A3xK
         swmwj0q87/EkaC8+0TnrFKt8yA3KRpQJjx2/Qtf5eC5lPDgxeBgRjihvI990dGjRmU5j
         eNFyVvuWtSsXFu0ZEn0YpfR0HMIBrPp97wZ2c=
Received: by 10.231.207.19 with SMTP id fw19mr4025008ibb.27.1312746297481;
 Sun, 07 Aug 2011 12:44:57 -0700 (PDT)
Received: by 10.231.205.148 with HTTP; Sun, 7 Aug 2011 12:44:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178924>

Hi,
 when I add a remote branch

$ git remote add otherUser git_repo_url

this is added locally configuration, how I can add this remote
branches configuration permanently similar to submodules ?

Regards.
