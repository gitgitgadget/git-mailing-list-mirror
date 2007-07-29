From: Florian Weimer <fw@deneb.enyo.de>
Subject: git-gui blame: show previous commit
Date: Sun, 29 Jul 2007 11:26:49 +0200
Message-ID: <87myxfzhk6.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 29 11:26:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF53A-0001IY-8n
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 11:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760888AbXG2J0w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 05:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760873AbXG2J0w
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 05:26:52 -0400
Received: from mail.enyo.de ([212.9.189.167]:4561 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760824AbXG2J0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 05:26:52 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1IF534-0001Qa-IW
	for git@vger.kernel.org; Sun, 29 Jul 2007 11:26:50 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1IF533-0005tF-GT
	for git@vger.kernel.org; Sun, 29 Jul 2007 11:26:49 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54099>

How can I view the previous commit touching a specific line, so that I
can see what was there before?  For instance, the change could be
whitespace-only, so that I want to dig deeper.
