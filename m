From: Jean Sacren <sakiwit@gmail.com>
Subject: Pull From Mirrored Repository
Date: Sun, 18 Sep 2011 08:45:15 -0600
Message-ID: <20110918144514.GL15295@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 16:45:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5Icm-00034Q-NF
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 16:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865Ab1IROpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 10:45:36 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:51162 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab1IROpf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 10:45:35 -0400
Received: by pzk1 with SMTP id 1so8090006pzk.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition;
        bh=mNY6ZfOSvAwJgWIHMP9DDePE6sRq9nVmTE4fMIW/ZVY=;
        b=L8CKtb93F0CRIodFyoPOfkq7bWOxsPMjARTdBi6GNtj45WHO1XnZiDEEsaTYvCqJEV
         xHKDADO7v162TQPsFJJuZKBEpZqDsa9/Hk6wz6dZref87aJWJo1TNWito9oLXrgjR/5E
         5i2cvBvsGUVnN1YwX6C9dSsE8tSiQiQxY6yuY=
Received: by 10.68.17.169 with SMTP id p9mr2736142pbd.195.1316357135118;
        Sun, 18 Sep 2011 07:45:35 -0700 (PDT)
Received: from localhost ([67.214.237.222])
        by mx.google.com with ESMTPS id f8sm56691849pbc.3.2011.09.18.07.45.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 07:45:33 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181610>

After pull from a mirrored repository, git status shows

# On branch master
# Your branch is ahead of 'origin/master' by [NUMBER] commits.
#
nothing to commit (working directory clean)


How to bring 'origin/master' update without syncing with the original
repository?

Thanks,

-- 
Jean Sacren
