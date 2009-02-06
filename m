From: Alex Bennee <kernel-hacker@bennee.com>
Subject: RPM to GIT tree integration?
Date: Fri, 6 Feb 2009 17:05:49 +0000
Message-ID: <b2cdc9f30902060905mb605a93oe8f9cc5795f3e008@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 18:07:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVUAh-0004k4-FN
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 18:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbZBFRFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 12:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753455AbZBFRFw
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 12:05:52 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:51255 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442AbZBFRFv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 12:05:51 -0500
Received: by yx-out-2324.google.com with SMTP id 8so370050yxm.1
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 09:05:50 -0800 (PST)
Received: by 10.90.65.5 with SMTP id n5mr827725aga.98.1233939949967; Fri, 06 
	Feb 2009 09:05:49 -0800 (PST)
X-Google-Sender-Auth: bda6708811661452
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108762>

Hi,

This is a wild shot in the dark but I thought I'd better ask in case
some one has. Has anyone created a script/tool that can take a src RPM and
apply it's patches (in sequence) to an existing GIT tree?

In my case I just want a GIT tree for a vendor kernel. I could just
prep an SRC RPM and commit the thing wholesale into GIT and start
hacking but then I'd loose all the history benefits.

-- 
Alex, homepage: http://www.bennee.com/~alex/
CV: http://www.bennee.com/~alex/cv.php
