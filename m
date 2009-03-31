From: Holger =?utf-8?B?V2Vpw58=?= <holger@zedat.fu-berlin.de>
Subject: [PATCH] Documentation: Remove an odd "instead"
Date: Tue, 31 Mar 2009 18:57:01 +0200
Organization: Freie =?utf-8?Q?Universit=C3=A4t?= Berlin
Message-ID: <20090331165701.GW30233737@CIS.FU-Berlin.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 19:02:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LohIN-0006c9-Uh
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 18:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182AbZCaQ5J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 12:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752679AbZCaQ5I
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 12:57:08 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:33865 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751905AbZCaQ5H (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 12:57:07 -0400
Received: from relay1.zedat.fu-berlin.de ([130.133.4.67])
          by outpost1.zedat.fu-berlin.de (Exim 4.69)
          with esmtp
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1LohGp-0004h6-BS>; Tue, 31 Mar 2009 18:57:03 +0200
Received: from mail.cis.fu-berlin.de ([160.45.11.138])
          by relay1.zedat.fu-berlin.de (Exim 4.69)
          with esmtp
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1LohGn-0004v7-SM>; Tue, 31 Mar 2009 18:57:01 +0200
Received: by Mail.CIS.FU-Berlin.DE (Exim 4.69)
          with local
          (envelope-from <holger@cis.fu-berlin.de>)
          id <1LohGn-02CI4a-O7>; Tue, 31 Mar 2009 18:57:01 +0200
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
Content-Disposition: inline
X-Operating-System: IRIX64 6.5.30f
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Originating-IP: 160.45.11.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115285>

Signed-off-by: Holger Wei=C3=9F <holger@zedat.fu-berlin.de>
---
 Documentation/git-clone.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 95f08b9..4072f40 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -117,7 +117,7 @@ then the cloned repository will become corrupt.
 --origin <name>::
 -o <name>::
 	Instead of using the remote name 'origin' to keep track
-	of the upstream repository, use <name> instead.
+	of the upstream repository, use <name>.
=20
 --upload-pack <upload-pack>::
 -u <upload-pack>::
--=20
1.6.2.1
