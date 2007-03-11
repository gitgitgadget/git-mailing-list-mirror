From: Avi Kivity <avi@qumranet.com>
Subject: [PATCH 0/2] git-send-email improvements
Date: Sun, 11 Mar 2007 19:19:42 +0200
Message-ID: <11736335842565-git-send-email-avi@qumranet.com>
To: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 18:41:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQS2p-0000wJ-5d
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 18:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933879AbXCKRlO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 13:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933877AbXCKRlO
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 13:41:14 -0400
Received: from il.qumranet.com ([82.166.9.18]:41886 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933879AbXCKRlM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 13:41:12 -0400
Received: by il.qumranet.com (Postfix, from userid 500)
	id 9FBB8A00B7; Sun, 11 Mar 2007 19:19:44 +0200 (IST)
X-Mailer: git-send-email 1.5.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41948>

The following two patches document the git-send-email aliases coniguration
variables, and add some more config variables to make usage a little easier.
Please consider applying.
