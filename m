From: Don Zickus <dzickus@redhat.com>
Subject: git-mailinfo fixes/features v3
Date: Wed, 14 Mar 2007 16:12:21 -0400
Message-ID: <11739031463211-git-send-email-dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 21:14:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRZrD-0003IB-3V
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 21:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933092AbXCNUNy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 16:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933120AbXCNUNy
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 16:13:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38206 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933092AbXCNUNx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 16:13:53 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2EKDqEi014177
	for <git@vger.kernel.org>; Wed, 14 Mar 2007 16:13:52 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2EKDqMZ025150
	for <git@vger.kernel.org>; Wed, 14 Mar 2007 16:13:52 -0400
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l2EKDpel007053
	for <git@vger.kernel.org>; Wed, 14 Mar 2007 16:13:52 -0400
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l2EKCQHe009138
	for <git@vger.kernel.org>; Wed, 14 Mar 2007 16:12:26 -0400
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l2EKCQaE009137
	for git@vger.kernel.org; Wed, 14 Mar 2007 16:12:26 -0400
X-Mailer: git-send-email 1.5.0.2.213.g18c8-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42221>

Another round of cleanups as noticed by Junio.  
Only the the first two patches were touched.

-coding style cleanups
-better boundary checking

Cheers,
Don
