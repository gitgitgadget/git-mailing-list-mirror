From: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
Subject: [PATCH 0/4] Header Includes Cleanup Part 2
Date: Tue, 31 Mar 2009 02:45:17 -0700
Message-ID: <1238492721-92484-1-git-send-email-nathaniel.dawson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 11:47:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoaYb-0007Pf-Sb
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 11:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbZCaJp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 05:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbZCaJp0
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 05:45:26 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:64362 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbZCaJpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 05:45:25 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2938874rvb.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 02:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=7j32FFZ/PRHYBCyS9G2rCmGVJ700aRloswZmGpl+R6U=;
        b=oz3bh0GX/xghGYGptT6EMq3Zbew0CDK5RqphumrW2IqDAN4lxJ77nf87ObtMOLpUr6
         xjW7wNUG5jsfYPICu6qGpNdUdxqkCE0wb7r7LTsODEqYxOKQAji88w/badTF7smCCSY0
         F17yX5K7TNtdPKHALWzI/7mxYD969a/WsYBmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=jLE5uYbiDks9kBVTHlO1BHNTY+Oar83V7JPYCazDk45XNR3H00PCh/xpxbuIeM3bSD
         MN7N1gJFj0vsXbqs4Geueo2iahgrhFBoRH3Boq8scTyVJJ0qSgz6EoGMZVEOk0r6cFzf
         447XW8sCzzxPbZvrkusDX2tKQNWT9d1UMYaGU=
Received: by 10.141.68.21 with SMTP id v21mr3366289rvk.273.1238492723794;
        Tue, 31 Mar 2009 02:45:23 -0700 (PDT)
Received: from localhost (ip68-98-113-49.ph.ph.cox.net [68.98.113.49])
        by mx.google.com with ESMTPS id g31sm16483802rvb.47.2009.03.31.02.45.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 02:45:23 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115240>

Here is part 2 of this project; I expect another 2 parts before
completion.

Regards,
Nathaniel P Dawson
