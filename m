From: Timur Tabi <timur@freescale.com>
Subject: Unknown option: no-signed-off-by-cc (git-send-email)
Date: Mon, 03 Mar 2008 10:06:15 -0600
Message-ID: <47CC21F7.3020204@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 17:08:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWDCG-0000wz-8r
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 17:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781AbYCCQGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 11:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754167AbYCCQGq
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 11:06:46 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:47325 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679AbYCCQGp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 11:06:45 -0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m23G6ZVw018977
	for <git@vger.kernel.org>; Mon, 3 Mar 2008 09:06:37 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m23G6Guo010026
	for <git@vger.kernel.org>; Mon, 3 Mar 2008 10:06:16 -0600 (CST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1.11) Gecko/20071128 SeaMonkey/1.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75938>

I just upgraded to 1.5.4, and when I tried to use git-send-email with my usual
parameters, I got this:

Unknown option: no-signed-off-by-cc
git-send-email [options] <file | directory>...

The documentation for git-send-email still lists this option.

-- 
Timur Tabi
Linux kernel developer at Freescale
