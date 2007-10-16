From: Michael Witten <mfwitten@MIT.EDU>
Subject: On Tabs and Spaces
Date: Tue, 16 Oct 2007 02:45:47 -0400
Message-ID: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 08:46:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhgBm-00065N-CS
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 08:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763413AbXJPGpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 02:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761446AbXJPGpw
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 02:45:52 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:48304 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760178AbXJPGpv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 02:45:51 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9G6jn7v021948
	for <git@vger.kernel.org>; Tue, 16 Oct 2007 02:45:49 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9G6jmgk026385
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 16 Oct 2007 02:45:48 -0400 (EDT)
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61095>

What are the rules about tabs and spaces in source code?

I'm having a terrible time with formatting,
especially in the perl scripts; there is a
mix of spaces and tabs.

from what I can deduce, single tabs are used
to introduce the equivalent of 8 spaces while
4 explicit spaces are used for half a tab.

I would recommend using all spaces, but the C
code seems to prefer all tabs.

In any case, some kind of standards need to be
set, because no one is following anything curr-
ently.

Sincerely,
Michael Witten
