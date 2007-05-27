From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: GIT on MinGW problem
Date: Sun, 27 May 2007 15:50:46 -0300
Message-ID: <4659D306.6030803@xs4all.nl>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Sun May 27 20:53:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsNrU-0005hl-Gu
	for gcvg-git@gmane.org; Sun, 27 May 2007 20:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbXE0Sw6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 14:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752806AbXE0Sw6
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 14:52:58 -0400
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:3961 "EHLO
	smtp-vbr2.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbXE0Sw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 14:52:57 -0400
Received: from [192.168.1.100] (c911deb6.bhz.virtua.com.br [201.17.222.182])
	(authenticated bits=0)
	by smtp-vbr2.xs4all.nl (8.13.8/8.13.8) with ESMTP id l4RIqpL3072840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 27 May 2007 20:52:53 +0200 (CEST)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <f3a2ke$9s7$1@sea.gmane.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48571>

Han-Wen Nienhuys escreveu:
> The only solution is to x-compile wish and include it as well.  I need several 
> strong drinks to start trying this.  Is there a MinGW wish port?

It turns out that spending a night in a brazilian/japanese karaoke bar
where thumping disco beats of the sadly deserted dance area permeates
the bleary out-of-tune portuguese singing of hormonally driven women did
enough to melt my mind.

There is a 1.5.2-3 installer which includes a cross-compiled tcltk. 

  http://lilypond.org/git/binaries/mingw/

What is the proper way to have the 'gitk' command start up with wish
automatically?


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
