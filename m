From: jidanni@jidanni.org
Subject: Re: git-gui: Warn when username and e-mail address is unconfigured?
Date: Fri, 12 Dec 2008 10:37:17 +0800
Message-ID: <87ljumi0f6.fsf@jidanni.org>
References: <b9fd99020812051218o1c337148u12b8e190c60f32eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 12 03:38:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAxvK-00032G-Jm
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756797AbYLLChV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756274AbYLLChV
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:37:21 -0500
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:33099 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755894AbYLLChU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Dec 2008 21:37:20 -0500
Received: from jidanni1.jidanni.org (122-127-32-244.dynamic.hinet.net [122.127.32.244])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 85080D26B9
	for <git@vger.kernel.org>; Thu, 11 Dec 2008 18:37:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102863>

On git-commit-tree(1)
  DIAGNOSTICS
       You don't exist. Go away!
           The passwd(5) gecos field couldn't be read

It should say that null is OK though.
jidanni:x:1000:1000:,,,:/home/jidanni:/bin/bash
gives
 Committer: jidanni <jidanni@jidanni.org>
which is what I want. No old fashioned English name for me.
