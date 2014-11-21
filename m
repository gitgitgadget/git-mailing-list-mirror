From: Vitaly Lipatov <lav@etersoft.ru>
Subject: Add an alias for --abort option
Date: Fri, 21 Nov 2014 15:41:48 +0300
Organization: Etersoft
Message-ID: <ae79db289351bca031a4a5adafb9615b@office.etersoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 21 13:48:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrndF-0006RP-Jr
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 13:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390AbaKUMsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 07:48:09 -0500
Received: from mail.etersoft.ru ([91.232.225.46]:44151 "EHLO mail.etersoft.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755095AbaKUMsI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 07:48:08 -0500
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Nov 2014 07:48:07 EST
Received: from roundcube.eterhost.ru (priv.etersoft.ru [91.232.225.6])
	by mail.etersoft.ru (Postfix) with ESMTP id E7E9280348
	for <git@vger.kernel.org>; Fri, 21 Nov 2014 15:41:48 +0300 (MSK)
X-Sender: lav@etersoft.ru
User-Agent: Roundcube Webmail/0.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

is it allowed add alias '--abandone' for --abort option in git commands 
(git am, git rebase, etc.)?
The word 'abort' have too negative meaning in the russian language.

For example, for git am we have three option names for continue 
operation:
--continue, -r, --resolved

-- 
Vitaly Lipatov,
Etersoft
