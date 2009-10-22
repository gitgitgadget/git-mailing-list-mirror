From: alexandrul <alexandrul.ct@gmail.com>
Subject: Proper attribution for modified files
Date: Thu, 22 Oct 2009 19:23:43 +0300
Message-ID: <4AE0870F.9050609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 22 18:23:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N10SC-0005sP-PQ
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 18:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692AbZJVQXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 12:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756687AbZJVQXq
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 12:23:46 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:61407 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756567AbZJVQXp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 12:23:45 -0400
Received: by fxm18 with SMTP id 18so9377102fxm.37
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 09:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=g4RSXZFL+tArF1tqOLcDkVASuJnZo9A57H8McpyxvHI=;
        b=N5fWNYaBhW9ilfu1sRWJm97UUy+6Kf0KlmLOSUX6x52YLyFO0s7lDx2VgAZEzVD/zY
         pJjjN9SiwYo292GvbSV7HojVV89u6qJ9EyQ3AVsZTliMqBM6zZVxr6d9XA7A+hfpark7
         L/0BMukLk8Bx1K73hUypuvhTTlNxa/cFXD75s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=Er5wCsad61lzLHBnECNbviZtnbsFOJRXKcjUjjm/pv6xFIkytvLMLZ0rVNFHpB+5S3
         s0tOo8gF0/oGEQICkmjZuxGWKPP2mjFaH3BbDVsg6Oq3kaShA5bmq3WUww0Ogp4U2FSg
         wPxWaue8Ft8fRZ7kr1SyxAUj5R5v+7pyGqWAA=
Received: by 10.102.236.11 with SMTP id j11mr4242623muh.3.1256228629251;
        Thu, 22 Oct 2009 09:23:49 -0700 (PDT)
Received: from ?192.168.2.8? ([89.136.114.133])
        by mx.google.com with ESMTPS id d6sm3368688fga.15.2009.10.22.09.23.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Oct 2009 09:23:48 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131029>

Hi,

I have started from git-instaweb script and modified it
in order to support my custom setup. The original script
starts with:

#!/bin/sh
#
# Copyright (c) 2006 Eric Wong
#

What would be the proper attribution to place in my modified script
in order to make it available for public download?

Have a nice day,
  A.
