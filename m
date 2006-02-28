From: Brian Gerst <bgerst@didntduck.org>
Subject: fatal: unexpected EOF
Date: Tue, 28 Feb 2006 08:02:15 -0500
Message-ID: <440449D7.3010508@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Feb 28 14:01:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE4Th-0002bj-LL
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 14:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWB1NA5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 08:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWB1NA5
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 08:00:57 -0500
Received: from quark.didntduck.org ([69.55.226.66]:45225 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751142AbWB1NA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 08:00:56 -0500
Received: from [192.168.1.2] (66-227-170-68.dhcp.aldl.mi.charter.com [66.227.170.68])
	(authenticated)
	by quark.didntduck.org (8.11.6/8.11.6) with ESMTP id k1SD0tv29467
	for <git@vger.kernel.org>; Tue, 28 Feb 2006 08:00:56 -0500
User-Agent: Thunderbird 1.5 (X11/20060210)
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16933>

Lately I've been receiving this error frequently from git.kernel.org:

Fetching pack (head and objects)...
fatal: unexpected EOF
cg-fetch: fetching pack failed

What is causing this?

--
						Brian Gerst
