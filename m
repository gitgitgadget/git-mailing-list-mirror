From: Vicent Marti <tanoku@gmail.com>
Subject: Libgit2 GSoC Update
Date: Thu, 3 Jun 2010 17:31:35 +0200
Message-ID: <AANLkTileZ2gL8KRCri1fx98OI01A1DE5ZrcaeajHzbj1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 03 17:32:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKCOq-0006JN-E4
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 17:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756405Ab0FCPb7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 11:31:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48205 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756298Ab0FCPb6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 11:31:58 -0400
Received: by fxm8 with SMTP id 8so191387fxm.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 08:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=4H3GbVFBwzNyiJB8ITljhJwrJUfF9xOQoogrW89VPdI=;
        b=QE7tQbuVp/tOr4aHDWBE+68xh2jMqnXcTBnHrH8N37cNQyiH6Jz7/xjxICGn2R0sQn
         6gp2xJ9yOeRmEQOc9srwpYqhYRd35y+uLh4dw3p0QM4pt+juiMHk7Hlzle5Axq6HAlz1
         t0Rdo9gLspoYGcTsGv3/h7wImV68nJb2n4nXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=LEcfjY5gly/Yk9a+tFQZNpAuEhHF2lwFOYyHSVN60taYdD6NghB5WkjkMZbwLWLWZ9
         mfrrGR7kHF0G4hUkoOU83Ps53xqZsf4leD9wvUL0hHuoBc9ota3de6/RvQT09WTrPYLm
         oUXLHkyLqtDsmWccPoaWev9recvHIdpN8xUsU=
Received: by 10.204.81.137 with SMTP id x9mr2972061bkk.80.1275579116916; Thu, 
	03 Jun 2010 08:31:56 -0700 (PDT)
Received: by 10.204.69.205 with HTTP; Thu, 3 Jun 2010 08:31:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148334>

Hello gentlemen,

just a quick status update to note that I've fixed all the issues
found on the previous review of the project. That first batch of
patches, together with several fixes which Ramsay has kindly commited
have been merged back into the libgit2 master repo [1].

=46eel free to test it out and comment back, if you have time.

Cheers,
Vicent Mart=ED
http://www.bellverde.org

[1]: http://repo.or.cz/w/libgit2.git
