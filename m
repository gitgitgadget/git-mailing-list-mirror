From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: MinGW binary installer available
Date: Wed, 07 Feb 2007 23:10:48 +0100
Message-ID: <45CA4E68.6070308@xs4all.nl>
References: <45C9E470.7030609@xs4all.nl> <Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jan Nieuwenhuizen <janneke@gnu.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 07 23:11:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEv02-0006cR-T6
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 23:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422816AbXBGWKn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 17:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422889AbXBGWKn
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 17:10:43 -0500
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:1936 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422816AbXBGWKm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 17:10:42 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
	(authenticated bits=0)
	by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id l17MAcrP054153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Feb 2007 23:10:39 +0100 (CET)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.9 (X11/20070130)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38979>

Johannes Schindelin escreveu:
> I played a little with it. IMHO it makes no sense to use it without a 
> bash, and without less. For example,
> 
> 	$ git init
> 	$ git add git.exe
> 	$ git status
> 	$ git commit -a -m initial
> 	$ git show HEAD
> 
> do not produce any output when issued in cmd.

can you check out the -2 build, at 
 
  http://lilypond.org/git/binaries/mingw/git-1.4.9993-2.mingw.exe
  
to see if this is better?

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
