From: Koosha Khajehmoogahi <koosha.khajeh@gmail.com>
Subject: [GSoC idea] Resumable clone
Date: Tue, 3 Mar 2015 00:33:33 +0100
Message-ID: <CACSCj9wkx1cSqcMbkt8+2S0GCzuBNeUjXyb4=n5_K7QzL_jawg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 03 00:34:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSZqt-0005X5-3u
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 00:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbbCBXeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 18:34:14 -0500
Received: from mail-qc0-f176.google.com ([209.85.216.176]:34056 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836AbbCBXeO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 18:34:14 -0500
Received: by qcwr17 with SMTP id r17so27631970qcw.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2015 15:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Jd1y5EUPLJUePDP95wLoF/8KXWd4y46l5r41ZC/wEjQ=;
        b=l9oOgSYy+ux5EB+I7crcUqHCldDnAs1uFgmqCgqXMorF9IqB2d/ANPG5mCyyNlkIVh
         YLgls4noQqBOBy5NESYpNMoXDVtPwgHipgXnonjSOSSQCtDQMGrbFZjzcRrilYFqPEmy
         KKQKTNCAPp3vHFxEQFGcJ+nvW0ojplT6htq/WQpa+2M7U1jBXZ5I3Q268pGv9y4N6meZ
         dzm15WpmPtvu+Bi7PLu9gZo3l5vUKBAnHkGC5zZlGRJUVVXMqt4Q0itDVR+iQxhNfapq
         aL2KjvdYv6X7Vy7UYwUI+02c+264bhbxpE3nJqSYnOprUHZosmKssLFADU7DWxyBKxwT
         IuUg==
X-Received: by 10.140.237.140 with SMTP id i134mr57122504qhc.70.1425339253306;
 Mon, 02 Mar 2015 15:34:13 -0800 (PST)
Received: by 10.140.92.146 with HTTP; Mon, 2 Mar 2015 15:33:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264635>

Among GSoC 2011 ideas of git [1], it was proposed that a GSoC project
could be implementing resumable clone for git. AFAIK, this feature is
still missing in git but could be a great idea to be implemented. Does
that sound OK to the community?

[1]: https://git.wiki.kernel.org/index.php/SoC2011Ideas#Resumable_clone
