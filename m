From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: GIT on MinGW, with tcltk for gitk
Date: Sun, 27 May 2007 18:19:12 -0300
Message-ID: <4659F5D0.2070406@xs4all.nl>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org> <4659D306.6030803@xs4all.nl> <f3cnm6$gda$1@sea.gmane.org> <00a601c7a09f$218c1020$0200a8c0@AMD2500>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Aaron Gray <angray@beeb.net>
X-From: git-owner@vger.kernel.org Sun May 27 23:21:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsQBG-0002Bu-80
	for gcvg-git@gmane.org; Sun, 27 May 2007 23:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbXE0VVa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 17:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757102AbXE0VVa
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 17:21:30 -0400
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:4125 "EHLO
	smtp-vbr16.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbXE0VV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 17:21:29 -0400
Received: from [192.168.1.100] (c911deb6.bhz.virtua.com.br [201.17.222.182])
	(authenticated bits=0)
	by smtp-vbr16.xs4all.nl (8.13.8/8.13.8) with ESMTP id l4RLLH3E080295
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 27 May 2007 23:21:24 +0200 (CEST)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <00a601c7a09f$218c1020$0200a8c0@AMD2500>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48580>

Aaron Gray escreveu:

> C:\Work\test>git init
> warning: templates not found C:/Program Files/Git/usr/bin@template_dir@
> Initialized empty Git repository in .git/
> 
> Aaron

Thanks for the report. Can you try again with 1.5.2-7  ? It should be available
in a few minutes.

Also, can you tell me if gitk.bat works for you?

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
