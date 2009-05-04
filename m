From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 0/3] git-am documentation
Date: Sun,  3 May 2009 23:46:55 -0700
Message-ID: <1241419618-20304-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 08:47:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0rxU-0002t7-Qo
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 08:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbZEDGrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 02:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbZEDGrD
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 02:47:03 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:49259 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbZEDGrB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 02:47:01 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1278725rvb.5
        for <git@vger.kernel.org>; Sun, 03 May 2009 23:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=+WBBxYeoNU7TX5EX294sehi0v1mpDEHRHWH6aEZ5H7c=;
        b=mFhsEI0D21rsu0+d7Y2DltL6ex+sDn7WuhOR1KhAa0JM22S0zuY8dzERvMl1kfJSjf
         5yIdYA3YBD2m0o493fp2lK5gDTLw2MgBvsYO9yMRaJy/kAILY+fiuMvumxgSixyXwGGa
         bfG/Gbfn8Vfde3Oq8NzgSH3NmnOtZ0SUqjCMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=vMPohSgdsvPf9ee5UrNWlW8xnzB6Mpg0eVDfk/Wn6ctH6l2U7zwM4R0/veNGzf9JuI
         uvYqO+slIGk4mtBLGCuXwdp583W9SH0TdQD1scKgT3FzocIMyeVAWQ3WlZS21o175U+H
         47qCADw7tvI6XDzSODt2Sn0M35jzlB6pkkPA8=
Received: by 10.143.11.19 with SMTP id o19mr1975423wfi.13.1241419621656;
        Sun, 03 May 2009 23:47:01 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 24sm447186wff.11.2009.05.03.23.46.59
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 May 2009 23:47:01 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 03 May 2009 23:46:58 -0700
X-Mailer: git-send-email 1.6.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118210>

The first two are minor grammatical fixes. I'm interested in what
people think about patch 3.

Stephen Boyd (3):
  git-am.txt: add an 'a', say what 'it' is, simplify a sentence
  git-am.txt: Use date instead of time or timestamp
  git-am.txt: reword extra headers in message body

 Documentation/git-am.txt |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)
