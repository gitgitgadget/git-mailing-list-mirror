From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCHv2 0/8] Small documentation updates
Date: Wed, 19 Sep 2012 00:25:26 +0100
Message-ID: <1348010734-664-1-git-send-email-philipoakley@iee.org>
To: gitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 01:25:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE7AQ-0005Mu-JF
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 01:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225Ab2IRXYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 19:24:46 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:24050 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751666Ab2IRXYp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2012 19:24:45 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgUFAMwBWVBZ8rU+/2dsb2JhbABFhSC3IYEJgn07gQIkiBeZCaFOkgsDpgSCZw
X-IronPort-AV: E=Sophos;i="4.80,445,1344207600"; 
   d="scan'208";a="47757872"
Received: from host-89-242-181-62.as13285.net (HELO localhost) ([89.242.181.62])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 19 Sep 2012 00:24:43 +0100
X-Mailer: git-send-email 1.7.8.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205895>

My first patch series, adds small documentation updates covering
points I had noticed or had to research elsewhere.

The small 'git' update applies on top of Junio's changes in 'next'.


V2 changes are in patches 3, 5, 6, and 7
The updated patches incorporate corrections and suggestions from
Junio Hamano and Matthieu Moy.


Philip

Philip Oakley (8):
  Doc: Bundle file usage
  Doc: shallow clone deepens _to_ new depth
  Doc: Improve shallow depth wording
  Doc: 'git' has a discussion section
  Doc: separate gitignore pattern sources
  Doc add: link gitignore
  Doc clean: add See Also link
  Doc branch: show -vv option and alternative

 Documentation/fetch-options.txt           |    3 +-
 Documentation/git-add.txt                 |    2 +-
 Documentation/git-branch.txt              |    5 ++-
 Documentation/git-bundle.txt              |   16 ++++++++------
 Documentation/git-clean.txt               |    4 +++
 Documentation/git.txt                     |    1 +
 Documentation/gitignore.txt               |   30 +++++++++++++++++-----------
 Documentation/technical/pack-protocol.txt |    6 +++-
 Documentation/urls.txt                    |    3 ++
 9 files changed, 45 insertions(+), 25 deletions(-)

-- 
1.7.8.msysgit.0
