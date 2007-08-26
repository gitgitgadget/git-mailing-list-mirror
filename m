From: Seth Falcon <sfalcon@fhcrc.org>
Subject: Question about git-log --date and default behavior
Date: Sun, 26 Aug 2007 16:35:31 -0700
Message-ID: <m2ejhpc1j0.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 01:35:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPRdk-0000fb-Ui
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 01:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbXHZXf3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 19:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbXHZXf3
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 19:35:29 -0400
Received: from JARLITE.FHCRC.ORG ([140.107.42.11]:59670 "EHLO
	jarlite.fhcrc.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbXHZXf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 19:35:29 -0400
Received: from jade.fhcrc.org (JADE.FHCRC.ORG [140.107.42.223])
	by jarlite.fhcrc.org (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id l7QNZRFr013749
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 26 Aug 2007 16:35:27 -0700
Received: from ziti.fhcrc.org (DORMOUSE.FHCRC.ORG [140.107.170.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jade.fhcrc.org (Postfix) with ESMTP id 9A5CEF2D9
	for <git@vger.kernel.org>; Sun, 26 Aug 2007 16:35:27 -0700 (PDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (darwin)
X-PMX-Version: 5.3.2.304607, Antispam-Engine: 2.5.1.298604, Antispam-Data: 2007.8.26.161122
X-FHCRC-SCANNED: Sun Aug 26 16:35:28 2007
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56744>

Is there a way have git-log use --date=local as the default for my
repositories?

I found that I could make an alias like 'llog' to do this, but I
wondered if there was a way that wouldn't require me to type anything
different.


+ seth

-- 
Seth Falcon
