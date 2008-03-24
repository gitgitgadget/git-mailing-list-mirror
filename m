From: Michael Gebetsroither <gebi@sbox.tugraz.at>
Subject: [bug] git-add won't add foo/.git/bar
Date: Tue, 25 Mar 2008 00:55:04 +0100
Organization: www.grml.org
Message-ID: <fs9f0o$jge$1@ger.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 00:56:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdwWD-0004ee-49
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 00:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbYCXXzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 19:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752907AbYCXXzN
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 19:55:13 -0400
Received: from main.gmane.org ([80.91.229.2]:44582 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752760AbYCXXzN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 19:55:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JdwVS-0008HO-GA
	for git@vger.kernel.org; Mon, 24 Mar 2008 23:55:10 +0000
Received: from 84.119.6.6 ([84.119.6.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 23:55:10 +0000
Received: from gebi by 84.119.6.6 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 23:55:10 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 84.119.6.6
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78129>

hi,

% git-add -f foo/.git/bar
fatal: unable to add foo/.git/bar to index

How do i add such a file to a git repository?

thx && cu,
michael
-- 
It's already too late!
