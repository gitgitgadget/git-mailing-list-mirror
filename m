From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [PATCH] documentation: web--browse: add a note about konqueror
Date: Thu, 27 Mar 2008 22:14:47 +0100
Message-ID: <200803272214.47115.barra_cuda@katamail.com>
References: <20080327001804.d120ca5e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio Hamano <junkio@cox.net>,
	Eric Wong <normalperson@yhbt.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	Xavier Maillard <xma@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 22:06:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JezHb-0003R3-9d
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 22:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760092AbYC0VEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 17:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760075AbYC0VEa
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 17:04:30 -0400
Received: from smtp.katamail.com ([62.149.157.154]:52721 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1760056AbYC0VE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 17:04:29 -0400
Received: (qmail 14533 invoked by uid 89); 27 Mar 2008 21:00:12 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO host159-57-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.159)
  by smtp2-pc with SMTP; 27 Mar 2008 21:00:09 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <20080327001804.d120ca5e.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78367>

On Thursday 27 March 2008, Christian Couder wrote:
> +For consistency, we also try such a trick if 'brower.konqueror.path' is

Squash this on top.

---
 Documentation/git-web--browse.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 92ef574..5ba0b9f 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -78,7 +78,7 @@ When 'konqueror' is specified by the a command line option or a
 configuration variable, we launch 'kfmclient' to try to open the HTML
 man page on an already opened konqueror in a new tab if possible.
 
-For consistency, we also try such a trick if 'brower.konqueror.path' is
+For consistency, we also try such a trick if 'browser.konqueror.path' is
 set to something like 'A_PATH_TO/konqueror'. That means we will try to
 launch 'A_PATH_TO/kfmclient' instead.
 
-- 
1.5.4.3
