From: Philip Oakley <philipoakley@iee.org>
Subject: [RFC/PATCH 0/2] Extend dot repository documentation
Date: Sun, 19 May 2013 12:54:07 +0100
Message-ID: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 19 13:54:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue2Bt-0007B6-LG
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478Ab3ESLyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 07:54:13 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:32142 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754444Ab3ESLyM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 07:54:12 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArMbAB29mFFZ8YNG/2dsb2JhbABbgwhkgh63b4Z1BH4XdIJ8O4ECJIgknDCfSo4EhHgDqHiDEDs
X-IronPort-AV: E=Sophos;i="4.87,703,1363132800"; 
   d="scan'208";a="424435051"
Received: from host-89-241-131-70.as13285.net (HELO localhost) ([89.241.131.70])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 19 May 2013 12:53:55 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224870>

The dot repository convention is not well know to users and its
documenation is hidden as a note in an ancilliary config variable's
documenation.

Document the dot repository 'do what I mean' convention in the
config variable it is used in, and in the cli (command line interface)
documenation page to give regular users a chance to find it.

Philip Oakley (2):
  config doc: add dot-repository note
  doc: command line interface (cli) dot-repository dwimmery

 Documentation/config.txt | 2 ++
 Documentation/gitcli.txt | 4 ++++
 2 files changed, 6 insertions(+)

-- 
1.8.1.msysgit.1
