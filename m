From: John Jendro <tacliat@gmail.com>
Subject: Feature Request: add a --current option to git branch
Date: Wed, 23 Feb 2011 11:08:28 -0800
Message-ID: <AANLkTimDE18XK8NOg++pxqs5LCJZ4m67Ygo4JvYDbw+F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 20:08:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsK4g-00013E-FO
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 20:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422Ab1BWTI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 14:08:29 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:52780 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932406Ab1BWTI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 14:08:29 -0500
Received: by qyg14 with SMTP id 14so3170398qyg.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 11:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=4Ez8rPfQHG4Q6jcoU6tH05XEu0KekRO+C3ee962A+4g=;
        b=DfLFs8LO31u5PKP4rINetlwNMOfrzF+gImgqvb3ViAuU9yjp7nsQ53HbZ9B05P4KSe
         O7aseQjnaP1X8Ptn8Vi9GrOSBUT9J4Vilbt0NZEdb/0ZSkdIk2D9YFX44O6zyKP9gc9z
         9Fxtaxj6qhubIyVxsctZfgIr7Jn6m0n5SZYTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=tdvGG6Srh3fIuj6vICf/R0RhCCIGrxrI5s7Irq5nFvzymTlq7jkLZYJBwcZpSOOIse
         wvduti5khXeO8GSu8NN8ATVGvNrqY1iP+naqO/lA5dV8UBzcDKNcUv5KSBX2sdYOxFkx
         LeVfvc+h1j+ON85NnCZXGQzHWGvOnQpslLy5s=
Received: by 10.229.220.78 with SMTP id hx14mr3494541qcb.46.1298488108076;
 Wed, 23 Feb 2011 11:08:28 -0800 (PST)
Received: by 10.229.190.15 with HTTP; Wed, 23 Feb 2011 11:08:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167713>

Yes I know this can be done with sed & grep, but --current should be a
standard thing for git branch to have.

-- 

-John Jendro
