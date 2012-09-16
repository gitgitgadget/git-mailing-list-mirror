From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 0/8] Small documentation updates
Date: Sun, 16 Sep 2012 11:57:55 +0100
Message-ID: <1347793083-4136-1-git-send-email-philipoakley@iee.org>
To: gitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 13:50:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDDN8-0006zX-5f
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 13:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360Ab2IPLuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 07:50:35 -0400
Received: from smtp2go.com ([207.58.142.213]:44296 "EHLO smtp2go.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357Ab2IPLuM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 07:50:12 -0400
X-Mailer: git-send-email 1.7.8.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205607>

This, my first patch series, adds small documentation updates covering
points I had noticed or had to research elsewhere.

The small 'git' update applies on top of Junio's changes in 'next'.
e.g. http://article.gmane.org/gmane.comp.version-control.git/204794 

Philip


Philip Oakley (8):
  Doc: Bundle file usage
  Doc: shallow clone deepens _to_ new depth
  Doc: Improve shallow depth wording
  Doc: 'git' has a discussion section
  Doc: separate gitignore pattern sources
  Doc add: link gitignore
  Doc clean: add See Also links
  Doc branch: show -vv option and alternative

 Documentation/fetch-options.txt           |    3 +-
 Documentation/git-add.txt                 |    3 +-
 Documentation/git-branch.txt              |    5 ++-
 Documentation/git-bundle.txt              |   16 ++++++++------
 Documentation/git-clean.txt               |    6 +++++
 Documentation/git.txt                     |    1 +
 Documentation/gitignore.txt               |   30 +++++++++++++++++-----------
 Documentation/technical/pack-protocol.txt |    8 ++++--
 Documentation/urls.txt                    |    3 ++
 9 files changed, 49 insertions(+), 26 deletions(-)

-- 
1.7.8.msysgit.0
