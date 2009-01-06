From: Lars Sadau <lars@sadau-online.de>
Subject: BUG?? INSTALL MAKEFILE
Date: Tue, 06 Jan 2009 14:26:16 +0100
Message-ID: <49635BF8.1010700@sadau-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 14:33:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKC3V-0003fN-0z
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 14:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbZAFNbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 08:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbZAFNbo
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 08:31:44 -0500
Received: from meili.mathematik.hu-berlin.de ([141.20.53.120]:55140 "EHLO
	meili.mathematik.hu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751894AbZAFNbo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jan 2009 08:31:44 -0500
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jan 2009 08:31:44 EST
Received: from localhost (localhost [127.0.0.1])
	by meili.mathematik.hu-berlin.de (Postfix) with ESMTP id E02CD21E005
	for <git@vger.kernel.org>; Tue,  6 Jan 2009 14:26:21 +0100 (CET)
Received: from meili.mathematik.hu-berlin.de ([127.0.0.1])
 by localhost (meili.mathematik.hu-berlin.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 13394-08 for <git@vger.kernel.org>;
 Tue,  6 Jan 2009 14:26:17 +0100 (CET)
Received: from [141.20.54.102] (brocken.mathematik.hu-berlin.de [141.20.54.102])
	by meili.mathematik.hu-berlin.de (Postfix) with ESMTP id 0CE1B21E004
	for <git@vger.kernel.org>; Tue,  6 Jan 2009 14:26:17 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (X11/20081112)
X-Virus-Scanned: amavisd-new at mathematik.hu-berlin.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104685>

Hallo,

i'm a brand-new git user. Just one minute ago I wanted to install git in
my home directory. The INSTALL file says type simply "make install", but
the makefile does a global installation.

Lars
