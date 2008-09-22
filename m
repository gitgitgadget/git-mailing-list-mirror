From: Johan Herland <johan@herland.net>
Subject: Re: [CORRECTION] Git-1.6.0.2-preview20080921 on Windows
Date: Mon, 22 Sep 2008 17:56:52 +0200
Message-ID: <200809221756.52900.johan@herland.net>
References: <82166911-C34F-439C-A2F3-CEBD7346A1D6@zib.de> <691F01A6-CA78-46DA-8388-C8339A3F0F04@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Sep 22 17:59:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khnnn-00039r-3R
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 17:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbYIVP5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 11:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752762AbYIVP5G
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 11:57:06 -0400
Received: from sam.opera.com ([213.236.208.81]:47348 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784AbYIVP5F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 11:57:05 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m8MFurJ9029907
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Sep 2008 15:56:58 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <691F01A6-CA78-46DA-8388-C8339A3F0F04@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96486>

On Sunday 21 September 2008, Steffen Prohaska wrote:
> Git-1.6.0.2-preview20080921 for Windows is available at
>
> [...]

This version fails for me when trying to use the bundled ssh.exe. I get 
a dialog saying:

	This application has failed to start because msys-crypto-0.9.8.dll
	was not found. Re-installing the application may fix the problem.

I get this both when starting ssh manually, and when started from 
e.g. "git clone".

Before installing the above version, I _uninstalled_ the previous 
version. If i _don't_ uninstall the previous version, and instead 
install this one on top of the old one, everything seems to work 
correctly.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
