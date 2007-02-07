From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: MinGW binary installer available
Date: Wed, 07 Feb 2007 16:34:28 +0100
Message-ID: <45C9F184.1060300@xs4all.nl>
References: <45C9E470.7030609@xs4all.nl> <Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45C9EB54.3040406@xs4all.nl> <Pine.LNX.4.63.0702071625341.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jan Nieuwenhuizen <janneke@gnu.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 07 16:34:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEooT-0008BW-MB
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 16:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030627AbXBGPeX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 10:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161358AbXBGPeW
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 10:34:22 -0500
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:2605 "EHLO
	smtp-vbr6.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030627AbXBGPeW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 10:34:22 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
	(authenticated bits=0)
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id l17FYHFf039215
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Feb 2007 16:34:17 +0100 (CET)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.9 (X11/20070130)
In-Reply-To: <Pine.LNX.4.63.0702071625341.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38933>

Johannes Schindelin escreveu:
> 
> You don't want to tell me that you x-compile Python when bundling 
> LilyPond, do you?

See

  http://lilypond.org/vc/gub.darcs/patches/python-2.5.patch
  https://sourceforge.net/tracker/?func=detail&atid=305470&aid=1597850&group_id=5470

I freely admit that it doesn't work very well, because the python build 
procedure is rather naive when it comes to detecting installed modules.

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
