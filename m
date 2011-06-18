From: Yann Dirson <ydirson@free.fr>
Subject: [PATCH 0/6] Small notes usability improvements
Date: Sat, 18 Jun 2011 23:06:42 +0200
Message-ID: <1308431208-13353-1-git-send-email-ydirson@free.fr>
References: <201106151253.57908.johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 18 23:07:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QY2jq-0007jg-P6
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 23:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951Ab1FRVHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 17:07:01 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:42403 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918Ab1FRVHA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 17:07:00 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id A7FE4D48111
	for <git@vger.kernel.org>; Sat, 18 Jun 2011 23:06:54 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.76)
	(envelope-from <ydirson@free.fr>)
	id 1QY2jF-0003Uw-AT
	for git@vger.kernel.org; Sat, 18 Jun 2011 23:06:53 +0200
X-Mailer: git-send-email 1.7.5.3
In-Reply-To: <201106151253.57908.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175983>

Patches 1 and 2 are just preparing things for patch 3.

Patch 4 is a (hopefully) temporary measure, to be able to implement a
real-life until notes workflow without having to wait for
refs/remotes/ to get its due restructuring,

Patch 5 addresses the anomaly reported earlier this week.

Patch 6 is a proposal to make "notes merge" more similar to "merge"
