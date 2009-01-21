From: Hannu Koivisto <azure@iki.fi>
Subject: git gui browser documentation bug
Date: Wed, 21 Jan 2009 19:12:31 +0200
Organization: NOYB
Message-ID: <83fxjcfurk.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 18:14:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPgeW-0004o6-Jg
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 18:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbZAURMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 12:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753176AbZAURMn
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 12:12:43 -0500
Received: from main.gmane.org ([80.91.229.2]:49191 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752381AbZAURMm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 12:12:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LPgd7-0005R7-C2
	for git@vger.kernel.org; Wed, 21 Jan 2009 17:12:41 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 17:12:41 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 17:12:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:3FIQ3pZLEVSIh4jGaN11ruDJaj8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106629>

Hi,

git-gui(1) says:

browser
    Start a tree browser showing all files in the specified commit
    (or HEAD by default).

However, if I try to run it with just "git gui browser", it doesn't
start (Cygwin, 1.6.1) or says "usage:
/usr/local/libexec/git-core/git-gui browser rev? path" (Linux,
1.6.1.28.gc32f76) -- I have to say "git gui browser HEAD".

-- 
Hannu
