From: Pascal Obry <pascal@obry.net>
Subject: [PATCH 0/2] Support backslash under Cygwin
Date: Sat, 13 Aug 2011 19:33:04 +0200
Message-ID: <1313256786-3687-1-git-send-email-pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 19:33:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsI5T-00075U-II
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 19:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab1HMRdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Aug 2011 13:33:25 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51420 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab1HMRdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2011 13:33:25 -0400
Received: by wyg24 with SMTP id 24so2741392wyg.19
        for <git@vger.kernel.org>; Sat, 13 Aug 2011 10:33:23 -0700 (PDT)
Received: by 10.227.28.4 with SMTP id k4mr2017789wbc.21.1313256803365;
        Sat, 13 Aug 2011 10:33:23 -0700 (PDT)
Received: from pascal.homeobry.net (ARouen-252-1-101-157.w90-23.abo.wanadoo.fr [90.23.164.157])
        by mx.google.com with ESMTPS id fr7sm3215709wbb.5.2011.08.13.10.33.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 13 Aug 2011 10:33:20 -0700 (PDT)
Received: from obry by pascal.homeobry.net with local (Exim 4.76)
	(envelope-from <obry@pascal.homeobry.net>)
	id 1QsI5G-0000yF-L0
	for git@vger.kernel.org; Sat, 13 Aug 2011 19:33:18 +0200
X-Mailer: git-send-email 1.7.6.447.gb9176
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179283>

This is a third version of this patch. In this version only the
log for PATCH 2/2 has been corrected.
