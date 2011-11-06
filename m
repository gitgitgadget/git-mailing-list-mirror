From: David Aguilar <davvid@gmail.com>
Subject: [ANNOUNCE] git-cola v1.7.0 tagged and released
Date: Sat, 5 Nov 2011 21:11:17 -0700
Message-ID: <20111106041115.GA3563@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git-cola@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 05:14:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMu85-0001hG-Vn
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 05:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855Ab1KFELh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 00:11:37 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35723 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab1KFELh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 00:11:37 -0400
Received: by iage36 with SMTP id e36so4389080iag.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 21:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=IXYYUlZFuOozV8FSrnaudjApuHXtrW/g52TN+xTXrBc=;
        b=pYpOfFtdQvMqOd3KlIyIqBT9Wu5lQ+v7SnBJzVoRmuj+vuFvoQfXxkrfGVbUkk0+Xj
         ufRwhM98KqceituF20EFJ2KeWep7Q+SYrF5p4+CLdab6YOwi9Wp3kc7iJL9Gmy81y6Qq
         noPyEHLvrNnHWlYHisjONoiwdzMXwVmUUGcQM=
Received: by 10.42.157.135 with SMTP id d7mr31706818icx.19.1320552696354;
        Sat, 05 Nov 2011 21:11:36 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net. [208.106.56.2])
        by mx.google.com with ESMTPS id lt8sm24149368pbb.0.2011.11.05.21.11.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 21:11:35 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184896>

The latest feature release of git-cola is available on github:

http://git-cola.github.com/

git-cola is a sleek and powerful git GUI.
It's fast, featureful, and fun to use.

Development is active after almost 4 years of development
so checkout our github repo for the latest and greatest:

https://github.com/git-cola/git-cola

New features since the last release
-----------------------------------
* A graphical DAG visualizer is available as `git dag`.
* The 'stash' widget includes a preview pane for instantly
  showing the contents of a stash.
* Usability improvements

`git-dag` is probably the most interesting new feature.
It visualizes DAGs using a 2D canvas which allows for unique
visualizations over a project's history.

`git-cola` has long had advanced interactive staging /
index-manipulation capabilities, difftool integration,
and much more.  It's written in python, portable to all
platforms where git is available, and GPL2 licensed.


Have fun,
-- 
				David @ https://github.com/davvid
