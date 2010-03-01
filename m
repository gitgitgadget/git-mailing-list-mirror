From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Add new option in the right click menu in git gui
Date: Mon, 1 Mar 2010 18:12:29 +0100
Message-ID: <20100301171222.GA35830@book.hvoigt.net>
References: <7fce93be1002181511v1c671f82u7f3d7cc6e3512bab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Mon Mar 01 18:12:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm9Ab-00075A-6A
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 18:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527Ab0CARMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 12:12:31 -0500
Received: from darksea.de ([83.133.111.250]:42524 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751515Ab0CARMa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 12:12:30 -0500
Received: (qmail 9480 invoked from network); 1 Mar 2010 18:12:28 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 1 Mar 2010 18:12:28 +0100
Content-Disposition: inline
In-Reply-To: <7fce93be1002181511v1c671f82u7f3d7cc6e3512bab@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141334>

On Fri, Feb 19, 2010 at 12:11:57AM +0100, Sylvain Rabot wrote:
> Hi,
> 
> In case of conflicts it is possible in git gui, through the right
> click menu, to use local or remote versions, but, unless I missed
> something, it is not possible, after using the merge tool, to add
> merged files to the index.
> 
> It would be nice if we could add merged files in the index directly in git gui.

I do not see anything missing. After resolving a conflict you usually
just need to add the files (in git gui click on the icon of the file).
Am I missing something? This is the usual conflict resolution workflow
for git, I see no need for an extra menu option.

cheers Heiko
