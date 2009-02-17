From: Francis Moreau <francis.moro@gmail.com>
Subject: Don't want to leave git for hg
Date: Tue, 17 Feb 2009 21:36:33 +0100
Message-ID: <m27i3ou7fy.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 21:38:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZWhn-0006wK-Tj
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 21:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbZBQUgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 15:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbZBQUgm
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 15:36:42 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:13420 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbZBQUgl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 15:36:41 -0500
Received: by fg-out-1718.google.com with SMTP id 16so535071fgg.17
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 12:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:to:subject:from:date
         :message-id:user-agent:mime-version:content-type;
        bh=Wu8fwQXIv56WNU1yJIhThZzb86Eqk20Mqqup0uckROg=;
        b=ZKA9O2JSsaBEfUGACLh621AcaEnbtP/OOxF71kjPvVFly1p4QhUC+9JBXnaUpFry+P
         xirllkM3HTSpjlKF/BOE26usjZlkeK7FCJs1fXxOAZBP2qzeOa1B4xh3BuQ0Y55WFCAS
         6NC8Brm5alyMKWQxqfSaSV/9v5oRlzRGd2X4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:from:date:message-id:user-agent:mime-version
         :content-type;
        b=VVNgNnIf+xBHo05DwlOEnbwXT/HEk+kiKo4oYfDuodrTO7PLo83mT4Kqo848iM5Ane
         hPY/kEXr2Mk0lcDxdwoQTZoXWLwqsYh9B74C2GUhsy4akaKDdI1xJque0Xtq880LgEf/
         qunAWSFNMWKRuxsQ6/3jwN93RNpMBRrvyyKaY=
Received: by 10.86.29.8 with SMTP id c8mr2301075fgc.67.1234902999612;
        Tue, 17 Feb 2009 12:36:39 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id e20sm185279fga.56.2009.02.17.12.36.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 12:36:38 -0800 (PST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110450>

Hello,

I unfortunately have to work on a hg repository.

For reasons that all git users understand I still want to use git.

So I'm wondering if others git users faced the same problem and if so
how they did workaround it ?

I found hg2git which could have solve my issue but it seems pretty old
and no more maintained.

Thanks
-- 
Francis
