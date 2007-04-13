From: Alan Larkin <nobrow@eircom.net>
Subject: fatal: Out of memory, malloc failed
Date: Fri, 13 Apr 2007 18:25:22 +0100
Message-ID: <461FBD02.6050105@eircom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 19:32:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcPdF-00046Y-G0
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 19:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1749667AbXDMRcF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 13:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbXDMRcF
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 13:32:05 -0400
Received: from mail09.svc.cra.dublin.eircom.net ([159.134.118.25]:6421 "HELO
	mail09.svc.cra.dublin.eircom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1749667AbXDMRcE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Apr 2007 13:32:04 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Apr 2007 13:32:03 EDT
Received: (qmail 1257 messnum 2875127 invoked from network[193.1.133.115/affront.ucd.ie]); 13 Apr 2007 17:25:22 -0000
Received: from affront.ucd.ie (HELO ?193.1.133.115?) (193.1.133.115)
  by mail09.svc.cra.dublin.eircom.net (qp 1257) with SMTP; 13 Apr 2007 17:25:22 -0000
User-Agent: Thunderbird 1.5.0.10 (X11/20070330)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44423>

Hello,

Its not a huge push Im trying to do here (<about 150Mb) but always malloc fails!

$ git push upload master
Fetching remote heads...
  refs/
  refs/heads/
  refs/tags/
updating 'refs/heads/master'
  from 0000000000000000000000000000000000000000
  to   4dc5525d0cc8ca24883c3fa1d5c29b3a105b4610
    sending 1024 objects
fatal: Out of memory, malloc failed

Any ideas? Thanks.
