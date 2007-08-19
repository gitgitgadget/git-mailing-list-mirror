From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [ANNOUNCE] git-gui 0.8.1
Date: Sun, 19 Aug 2007 03:59:31 -0400
Message-ID: <20070819075931.GT27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 19 09:59:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMfhH-00055t-5o
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 09:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbXHSH7i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 19 Aug 2007 03:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbXHSH7i
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 03:59:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33015 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbXHSH7h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Aug 2007 03:59:37 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IMfh6-0003MF-2c; Sun, 19 Aug 2007 03:59:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8C49B20FBAE; Sun, 19 Aug 2007 03:59:31 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56123>

This is really just a very minor maintenance release of git-gui.

The following are the changes since git-gui 0.8.0:

Shawn O. Pearce (1):
      git-gui: Avoid Tcl error in popup menu on diff viewer

V=C3=A4in=C3=B6 J=C3=A4rvel=C3=A4 (1):
      git-gui: Added support for OS X right click

Hopefully we can get the i18n work merged real-soon-now, for the
upcoming 0.9.x tree.


Junio, when you merge this into git.git please make sure you have
the gitgui-0.8.1 tag fetched... otherwise your next rc release
won't use it in the git-gui/version file.

--=20
Shawn.
