From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 0/4] enhancements to 'git verify-pack'
Date: Thu, 28 Feb 2008 00:25:16 -0500
Message-ID: <1204176320-31358-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 06:26:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUbHM-0004Z9-KR
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 06:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbYB1FZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 00:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbYB1FZW
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 00:25:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:61471 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbYB1FZW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 00:25:22 -0500
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JWX00B63OE9QT70@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 28 Feb 2008 00:25:21 -0500 (EST)
X-Mailer: git-send-email 1.5.4.2.200.g99e75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75353>

The following patches fix a long standing limitation about OBJ_OFS_DELTA
objects and verify-pack.


Nicolas
