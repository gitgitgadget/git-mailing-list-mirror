From: Andi Kleen <andi@firstfloor.org>
Subject: Profile feedback patchkit v2
Date: Mon,  7 Jul 2014 23:35:07 -0700
Message-ID: <1404801311-15365-1-git-send-email-andi@firstfloor.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 08:35:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4P0E-0005EQ-8B
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 08:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbaGHGfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 02:35:31 -0400
Received: from one.firstfloor.org ([193.170.194.197]:33416 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbaGHGfa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 02:35:30 -0400
Received: from basil.firstfloor.org (184-100-237-164.ptld.qwest.net [184.100.237.164])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 8F4DC8677C
	for <git@vger.kernel.org>; Tue,  8 Jul 2014 08:35:28 +0200 (CEST)
Received: by basil.firstfloor.org (Postfix, from userid 1000)
	id 44DE0A207B; Mon,  7 Jul 2014 23:35:16 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253005>

Fix the bitrotted profile feedback support.

Changes to v1:
- Remove obsolete comment
- Remove controversal diff script.
