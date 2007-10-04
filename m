From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Question about "git commit -a"
Date: Thu, 4 Oct 2007 17:38:25 +0200
Message-ID: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 04 17:38:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdSmd-0000BC-KR
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 17:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756487AbXJDPi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 11:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756429AbXJDPi2
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 11:38:28 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:15562 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756144AbXJDPi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 11:38:28 -0400
Received: by nz-out-0506.google.com with SMTP id s18so192370nze
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 08:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=AkeD4CRmYfqt0QZBpdA0As7rXzdWID0Wt/cZ6+GyjpQ=;
        b=HNoo3D4OTEIy8k+k69KvRBR7dmfmHv8sBJm4wNJGHzWS9ls+rEgcq0GNlIIG+6vPs9pIRL8yPT2PGCWdW7ns337bOJ/JnbQXrr2WEQzkVaQ+GpMf20q2POVgbpehAkjsHUS0W+DRpwAMVg07fYwcCYOP4N1PAwPe5PZIt5HliZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Fpsof5Rs8EVw8v1//1XoV+9W1OqZDAEcSrg41gOWpNT15ixB1JHo428lh/RXu5g/wpX6Fq1jIuOckr3H3i+azWgOotyTt9j9/1ZTXpJYQ9D24h3WyBGm7X26W8pIWaqXmLWhS6fEhZL2CTeAmIAYBTVo/u6agT3jiWWCbFQ+640=
Received: by 10.142.226.2 with SMTP id y2mr991439wfg.1191512305118;
        Thu, 04 Oct 2007 08:38:25 -0700 (PDT)
Received: by 10.143.43.21 with HTTP; Thu, 4 Oct 2007 08:38:25 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59964>

Hi all,
I was just wondering why git commit doesn't default to "-a" (yes, it's
another question that came up during a chat with a mercurial user) and
I didn't find an answer to that.

It's not a big deal but I strongly suspect that the large majority of
the git users never user git commit without the option "-a".

Am I wrong?

Regards,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
http://ubuntista.blogspot.com
