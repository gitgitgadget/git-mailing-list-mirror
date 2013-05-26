From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/6] git send-email suppress-cc=self fixes
Date: Sun, 26 May 2013 17:40:52 +0300
Message-ID: <1369579187-27573-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 26 16:40:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ugc7f-0000ZA-DN
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 16:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523Ab3EZOkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 10:40:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36786 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753295Ab3EZOka (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 10:40:30 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4QEeUJU031278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Sun, 26 May 2013 10:40:30 -0400
Received: from redhat.com (vpn-202-184.tlv.redhat.com [10.35.202.184])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r4QEeSbV015362
	for <git@vger.kernel.org>; Sun, 26 May 2013 10:40:29 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225544>

This includes bugfixes related to handling of --suppress-cc=self
flag. Tests are also included.

-- 
MST
