From: Paul Mackerras <paulus@samba.org>
Subject: Please pull gitk.git master branch
Date: Sun, 12 Dec 2010 17:31:35 +1100
Message-ID: <20101212063135.GA7677@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 12 07:31:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRfTG-0003ww-Op
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 07:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969Ab0LLGbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 01:31:41 -0500
Received: from ozlabs.org ([203.10.76.45]:33748 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840Ab0LLGbl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 01:31:41 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 1E517B70A9; Sun, 12 Dec 2010 17:31:40 +1100 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163473>

Junio,

Please do a pull from

git://git.kernel.org/pub/scm/gitk/gitk.git

to get the commits listed below.

Thanks,
Paul.

 gitk        |   81 +++-
 po/pt_BR.po | 1277 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 po/sv.po    |  601 ++++++++++++++--------------
 3 files changed, 1654 insertions(+), 305 deletions(-)
 create mode 100644 po/pt_BR.po

Alexandre Erwin Ittner (1):
      gitk: Add Brazilian Portuguese (pt-BR) translation

Kirill Smelkov (1):
      gitk: Show notes by default (like git log does)

Peter Krefting (1):
      gitk: Update Swedish translation (290t)

Stefan Haller (2):
      gitk: Prevent the text pane from becoming editable
      gitk: Make text selectable on Mac

Thomas Rast (1):
      gitk: Add the equivalent of diff --color-words
