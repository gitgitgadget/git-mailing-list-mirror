From: Bill Lear <rael@zopyra.com>
Subject: Limiting git log to skip commits with large number of diffs
Date: Mon, 24 Mar 2008 13:53:58 -0600
Message-ID: <18408.1750.387050.24847@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 20:55:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdsl6-0003Tc-1A
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 20:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbYCXTyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 15:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754533AbYCXTyF
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 15:54:05 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61869 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880AbYCXTyE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 15:54:04 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id m2OJs3p15818;
	Mon, 24 Mar 2008 13:54:03 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78087>

I would like to tell git log "Do not list, or list in
very abbreviated form, commits with greater than N diffs".

The man page does not seem to indicate that this could
be done.

Is there a way to do this?


Bill
