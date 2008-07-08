From: "Theodore Ts'o" <tytso@MIT.EDU>
Subject: Two quick patches for guilt v0.30
Date: Mon,  7 Jul 2008 20:03:10 -0400
Message-ID: <1215475392-26221-1-git-send-email-tytso@mit.edu>
Cc: git@vger.kernel.org
To: jeffpc@josefsipek.net
X-From: git-owner@vger.kernel.org Tue Jul 08 02:07:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG0k9-000863-8I
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 02:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782AbYGHAGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 20:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754776AbYGHAGo
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 20:06:44 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:53784 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754664AbYGHAGn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jul 2008 20:06:43 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m6803JQu023857;
	Mon, 7 Jul 2008 20:03:19 -0400 (EDT)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m6803C0R018878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 7 Jul 2008 20:03:16 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KG0fo-0007fF-5h; Mon, 07 Jul 2008 20:03:12 -0400
X-Mailer: git-send-email 1.5.6.1.205.ge2c7.dirty
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87669>

Hi Jeff, here are two quick patches for guilt, versus v0.30.  The
second is needed for people using the latest git (on the master
branch), so it'd be great if you could get this out.

Thanks, regards,

					- Ted
