From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: fatal: ambiguous argument 'HEAD': unknown revision or path not in
	the working tree.
Date: Fri, 8 Jun 2007 12:08:31 +0200
Message-ID: <20070608100831.GA2335@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 08 12:08:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwbOe-0005LC-FK
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 12:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966369AbXFHKId (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 06:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967034AbXFHKId
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 06:08:33 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:39737 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966369AbXFHKId (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 06:08:33 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 9ABB53F3F9; Fri,  8 Jun 2007 12:08:31 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49453>

Hello,

        (s017241) [/usr/src/linux-2.6] git checkout v2.6.20
        warning: You appear to be on a branch yet to be born.
        warning: Forcing checkout of v2.6.20.
        fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
        Use '--' to separate paths from revisions
        Cannot detach HEAD

(s017241) [/usr/src/linux-2.6] git version
git version 1.5.2.1

what is going wrong here?

        Thomas
