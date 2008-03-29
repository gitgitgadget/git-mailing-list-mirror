From: Paul <lists@pote.com>
Subject: why multiple password prompts?
Date: Sat, 29 Mar 2008 11:44:05 -0400 (Eastern Daylight Time)
Message-ID: <alpine.WNT.1.10.0803291141550.11992@znlsyl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 29 17:16:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jfdjb-0000tz-30
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 17:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbYC2QQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 12:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbYC2QQE
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 12:16:04 -0400
Received: from mail-out8.nyct.net ([216.139.141.8]:49215 "EHLO mail.nyct.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752487AbYC2QQD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 12:16:03 -0400
X-Greylist: delayed 1911 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Mar 2008 12:16:03 EDT
Received: from tarsier.pote.com (adsl-216-139-154-3.nyct.net [216.139.154.3])
	by mail.nyct.net (8.14.2/8.14.1) with ESMTP id m2TFiA1D012065
	for <git@vger.kernel.org>; Sat, 29 Mar 2008 11:44:10 -0400 (EDT)
	(envelope-from lists@pote.com)
Received: from [64.62.217.52] 
	by tarsier.pote.com with esmtpsa (Exim 4.63 #1 (Debian))
	for git@vger.kernel.org
	id 1JfdDx-0005o7-0J; Sat, 29 Mar 2008 11:44:05 -0400
User-Agent: Alpine 1.10 (WNT 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78471>

When I do a simple git-pull over SSH, why does it typically prompt me 
for my SSH password two or three times? And no, I am not inputting it 
wrong.

$ git-pull
Password:
Password:
Password:
remote: Generating pack...
