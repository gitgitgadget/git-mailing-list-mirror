From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 0/2] Enable git-branch to show detached HEAD
Date: Wed,  3 Jan 2007 21:10:08 +0100
Message-ID: <11678550103703-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 03 21:08:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2CPC-0002ls-66
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 21:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbXACUIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 15:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbXACUIG
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 15:08:06 -0500
Received: from mail48.e.nsc.no ([193.213.115.48]:64009 "EHLO mail48.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932067AbXACUIF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 15:08:05 -0500
Received: from localhost.localdomain (ti231210a080-8960.bb.online.no [80.212.179.6])
	by mail48.nsc.no (8.13.8/8.13.5) with ESMTP id l03K806q018889;
	Wed, 3 Jan 2007 21:08:01 +0100 (CET)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.5.0.rc0.ge900
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35886>

These two patches let git-branch show a detached HEAD in a sensible way:

 [PATCH 1/2] Refactor print-functions in builtin-branch
 [PATCH 2/2] git-branch: show detached HEAD
