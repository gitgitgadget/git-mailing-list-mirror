From: Gerrit Pape <pape@smarden.org>
Subject: cogito selftests failures with git 1.5.1
Date: Tue, 10 Apr 2007 10:16:26 +0000
Message-ID: <20070410101626.10047.qmail@0be9eada36064d.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 15:11:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbDOo-0007s6-2x
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 12:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbXDJKQI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 06:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbXDJKQI
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 06:16:08 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:57060 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752770AbXDJKQH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 06:16:07 -0400
Received: (qmail 10048 invoked by uid 1000); 10 Apr 2007 10:16:26 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44122>

Hi, while cogito 0.18.2 builds and selftests fine with git 1.4.4.4, the
following selftests fail with 1.5.1 on Debian: t9105-fetch-local.sh:20,
t9204-merge-weird-conflicts.sh:8,20.

Is there still work done on cogito?

Thanks, Gerrit.
