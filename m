From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH 00/10] Docs: git tag
Date: Mon, 28 Mar 2011 15:32:06 +0000
Message-ID: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 17:54:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Elr-00045V-Cm
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 17:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563Ab1C1PyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 11:54:18 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49622 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab1C1PyR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 11:54:17 -0400
Received: by eyx24 with SMTP id 24so1202218eyx.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:message-id:x-mailer:date;
        bh=2MVnSCcCop8E1bHnOC8C4OVVnCSYyXFKoMkSjJaUILM=;
        b=r/XuTQMVUqaJUp61tf2eapSOzhbd0JHv+CGlQaUZ4zG3oIbmvScwYrz2+i4IwYwatX
         SRYPhpCr+TkcRD6Buv7m4sQ3nbv39+tUZrEta23GSJrFps+RESNOLYbTYCbc5tsx7H4y
         pI7r/JoxrNaQXIMONnK2YzyBYprHjIARl+P4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:message-id:x-mailer:date;
        b=iBo0817c0LHCuiDFw4JCQuSZNCqVgcdN8YkRLzNZ38fvKRwKwOXWy0bu5tSRbDZ83r
         WAVsuJLKetRN6/KIeeSOueHrgNxLr9TCgGcNbB4KDxOc5GrpzoZsZyVw4wtjLJ/th6Fa
         oAJiZZ3MyVCe5j8n5AcvZiw9rzsdZiM7rXEoU=
Received: by 10.213.20.143 with SMTP id f15mr1373081ebb.6.1301327656656;
        Mon, 28 Mar 2011 08:54:16 -0700 (PDT)
Received: from localhost.localdomain ([174.143.243.243])
        by mx.google.com with ESMTPS id v1sm2878807eeh.6.2011.03.28.08.54.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 08:54:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.18.g68fe8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170138>

Small patches fixing up the `git tag' docs.

Michael Witten (10):
  Docs: git tag: Add `the'
  Docs: git tag: peoples back -> people's backs
  Docs: git tag: Revise a paragraph.
  Docs: git tag: other's -> the other person's
  Docs: git tag: Streamline a sentence.
  Docs: git tag: Add missing 'the'
  Docs: git tag: Use 'who' again
  Docs: git tag: Remove superfluous 'with'
  Docs: git tag: Use semicolon
  Docs: git tag: Rewrite discussion of GIT_COMMITTER_DATE

 Documentation/git-tag.txt |   39 ++++++++++++++++++++-------------------
 1 files changed, 20 insertions(+), 19 deletions(-)

-- 
1.7.4.18.g68fe8
