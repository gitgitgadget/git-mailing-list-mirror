From: Pascal Obry <pascal@obry.net>
Subject: [PATH 0/2] On Cygwin support both UNIX and DOS style path-names
Date: Fri,  5 Aug 2011 18:10:12 +0200
Message-ID: <1312560614-20772-1-git-send-email-pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 18:10:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpMz6-0003e8-5o
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 18:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756564Ab1HEQKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 12:10:46 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63745 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623Ab1HEQKp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 12:10:45 -0400
Received: by wyf22 with SMTP id 22so1333812wyf.19
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 09:10:44 -0700 (PDT)
Received: by 10.216.229.220 with SMTP id h70mr742030weq.1.1312560644313;
        Fri, 05 Aug 2011 09:10:44 -0700 (PDT)
Received: from pascal.homeobry.net (AVelizy-154-1-101-151.w90-2.abo.wanadoo.fr [90.2.59.151])
        by mx.google.com with ESMTPS id es3sm1853588wbb.6.2011.08.05.09.10.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Aug 2011 09:10:43 -0700 (PDT)
Received: from obry by pascal.homeobry.net with local (Exim 4.76)
	(envelope-from <obry@pascal.homeobry.net>)
	id 1QpMyv-0005Px-3N
	for git@vger.kernel.org; Fri, 05 Aug 2011 18:10:41 +0200
X-Mailer: git-send-email 1.7.6.404.g5d2fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178799>

This is the second version of this serie after Theo review. It includes
the patch from Theo first and mine after.

Let me know if it looks ok. Thanks.
