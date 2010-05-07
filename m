From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: tracking un-committed patches in mailing list?
Date: Fri, 7 May 2010 13:44:28 -0400
Message-ID: <m2u46a038f91005071044w15594056sb7753b6268979228@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 07 19:44:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OARbd-0007M6-L7
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 19:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757190Ab0EGRow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 13:44:52 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:32954 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756347Ab0EGRow (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 13:44:52 -0400
Received: by gxk9 with SMTP id 9so979578gxk.8
        for <git@vger.kernel.org>; Fri, 07 May 2010 10:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=jVdg8Z1gXm7NPb1rpTH1U6V9O9QYI+L3sqb0xmYfwYw=;
        b=IYetQcR1fk+BCuYV0EfPOhYexqmDXncJj2VKW6fWaVnfq9QdiEuO9nu9gXRtF5MFhr
         xRByCIJ17HRncHDKwPf44kV7h55Xp1jCN9lBX5g+HErXgwM5cDszFJTCeJKN7G3Piia0
         djpOmv+8SnN/hjMUC92iFioSVDklFvRYCJtKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=V8fT1hnwswOQv7gyWzcgF4Qcle51L+dHKYg4EJs3eX3wfQYMgUxs3QUvDGBleTvlVo
         aowVx3qXjZp+O8EyVyxiUWHauKKd9nZfklSeClO0ML6RrRK8dSAL+knmfI1H3h2lxIiZ
         jFSV2JOmWD/GQ33wjpNC8zp+wdRkDofQV4WQg=
Received: by 10.231.182.79 with SMTP id cb15mr92017ibb.71.1273254289557; Fri, 
	07 May 2010 10:44:49 -0700 (PDT)
Received: by 10.231.120.230 with HTTP; Fri, 7 May 2010 10:44:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146546>

ISTR some folks here in git@vger are tracking patches that were posted
to the list but not committed with a bot that subscribes to the list.

I _thought_ it was ciabot. Maybe it's something else? A read through
the git tools wikipage doesn't lead to any likely suspects...

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
