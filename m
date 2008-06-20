From: Stephan Beyer <s-beyer@gmx.net>
Subject: some small changes for rebase-i
Date: Fri, 20 Jun 2008 04:45:32 +0200
Message-ID: <1213929935-15093-1-git-send-email-s-beyer@gmx.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 04:46:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9WeL-0006EA-Tc
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 04:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbYFTCpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 22:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbYFTCps
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 22:45:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:48860 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751945AbYFTCpl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 22:45:41 -0400
Received: (qmail invoked by alias); 20 Jun 2008 02:45:38 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp058) with SMTP; 20 Jun 2008 04:45:38 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/tmUYxWaHtUbVb5L6u18Q1o8uSbvEG/LpG5iE3W+
	6MqcoFUQtIL8Ou
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K9Wd5-0003ww-Gw; Fri, 20 Jun 2008 04:45:35 +0200
X-Mailer: git-send-email 1.5.5.1.561.gd8556
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85588>

Hi,

the following small patchset can be applied to "pu" (i.e. to
js/rebase-i-sequencer, which has been in "next" before it
has been rewound.)

The first adds some tests that seemed useful to me during early
sequencer prototype development,
the second is just one for the look and
the third makes rebase-i use OPTIONS_SPEC.

Regards,
  Stephan
