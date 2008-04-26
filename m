From: Alenoosh Baghumian <alenoosh@opensourceclub.org>
Subject: git cvsimport problem
Date: Sat, 26 Apr 2008 15:54:58 +0330
Message-ID: <48131F1A.3010409@opensourceclub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 13:50:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpivE-0003By-5F
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 13:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048AbYDZLtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 07:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbYDZLtl
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 07:49:41 -0400
Received: from static.88-198-8-89.clients.your-server.de ([88.198.8.89]:38527
	"EHLO julius.technotux.org" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752807AbYDZLtl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Apr 2008 07:49:41 -0400
X-Greylist: delayed 1516 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Apr 2008 07:49:41 EDT
Received: from localhost (localhost [127.0.0.1])
	by julius.technotux.org (Postfix) with ESMTP id 95182F6C0B6
	for <git@vger.kernel.org>; Sat, 26 Apr 2008 13:24:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at julius.technotux.org
Received: from julius.technotux.org ([127.0.0.1])
	by localhost (julius.technotux.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e4hWBphlgJ7m for <git@vger.kernel.org>;
	Sat, 26 Apr 2008 13:24:56 +0200 (CEST)
Received: from [192.168.1.2] (unknown [80.191.128.152])
	by julius.technotux.org (Postfix) with ESMTP id D4225F6C084
	for <git@vger.kernel.org>; Sat, 26 Apr 2008 13:24:54 +0200 (CEST)
User-Agent: Icedove 1.5.0.10 (X11/20070329)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80368>

Hi

I want to import a cvs project , here's what I do :

1)  cvs check out
2) $ cd cvs-pro
3) cvs-pro$ git cvsimport -C path/to/destination -v

it starts executing but finally stops with the following error:
git-cvsimport: fatal: cvsps reported error


what is the problem ?
Am I doing anything wrong ?

Thanks in advance for your help .

Alenoosh
