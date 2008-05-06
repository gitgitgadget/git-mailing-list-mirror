From: Sebastian Schuberth <sschuberth@visageimaging.com>
Subject: Re: [PATCH] mergetool: Make ECMerge use the settings as specified
 by   the user in the GUI
Date: Tue, 06 May 2008 14:06:14 +0200
Message-ID: <fvphjn$im$1@ger.gmane.org>
References: <482038C4.6050402@visageimaging.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 14:11:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtM0X-0003wN-0X
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 14:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758745AbYEFMKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 08:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758628AbYEFMKG
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 08:10:06 -0400
Received: from main.gmane.org ([80.91.229.2]:40301 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758185AbYEFMKE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 08:10:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JtLzf-0001Wy-7j
	for git@vger.kernel.org; Tue, 06 May 2008 12:10:03 +0000
Received: from port-83-236-129-242.static.qsc.de ([83.236.129.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 May 2008 12:10:03 +0000
Received: from sschuberth by port-83-236-129-242.static.qsc.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 May 2008 12:10:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: port-83-236-129-242.static.qsc.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <482038C4.6050402@visageimaging.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81355>

> be used, which can be misleading. Specifying the "--default" command line
> option changes this behavior so that always the user specfified GUI settings
> are used.
> 
> Signed-off-by: Sebastian Schuberth <sschuberth@visageimaging.com>

Sorry, I just saw the typo, of course this should say "[...] user specified GUI settings [...]". And the subject has two spaces between "[...] by  the [...]", which should be only one.

-- 
Sebastian Schuberth
