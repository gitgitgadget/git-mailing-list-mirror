From: Jon Smirl <jonsmirl@gmail.com>
Subject: diff: unmerged path?
Date: Mon, 30 Mar 2009 22:47:15 -0400
Message-ID: <9e4733910903301947g20ade881q6a49f9cd8731b8f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 04:48:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoU21-0008MV-SU
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 04:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509AbZCaCrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 22:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760539AbZCaCrU
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 22:47:20 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:61040 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761629AbZCaCrT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 22:47:19 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2882152qwh.37
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 19:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=QAwDz+d0D4rSh39lhWkHkVGLHRYTT/SU6WgyyS1yqtQ=;
        b=eUCY45kdFbBluHgsgA8kOstjmYcEH5dfbq7afg6lo02p01RWQO4ingHtknQoMOaXK0
         /HaxGKqR7v19utUOVwSnfvqCLa1ao+FwMlLgI/UutgitATzKjjUbC99TDvWsVL5laKSJ
         0qo3kulipGwWeka7q2n4oLwH1Ft3ZGIqf4W+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=wVciMCG8cafJoVGUB04ZvMsB6STLjjJPXpgemW4fZhE8P8RgA11MMNqDQXlWhrUTn4
         OVlabnTago/etPvFoLkEwf3rgc1IigJjzHa2JF2pz/Kf2ccBRehbf5MFFr3Ph3RHGwTk
         uER4u1U/kDCa88x1G+4cQFn2Xa+S49bZ3UcLs=
Received: by 10.220.99.149 with SMTP id u21mr1959548vcn.94.1238467635960; Mon, 
	30 Mar 2009 19:47:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115206>

What does it mean when I have an unmerged path?

jonsmirl@terra:/home/apps/u-boot$ git diff
* Unmerged path api_examples/intellon.c
jonsmirl@terra:/home/apps/u-boot$

api_examples/intellon.c is a newly created file under stgit.

-- 
Jon Smirl
jonsmirl@gmail.com
