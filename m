From: "Kristoff, Paul" <Paul.Kristoff@Teradata.com>
Subject: FW: Trouble with initial fetch
Date: Tue, 1 Apr 2008 10:13:23 -0400
Message-ID: <2BE8037008FE23488F8A04DF9D2349700301AFD5@susday7667.TD.teradata.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 01 16:16:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JghFe-0005SL-Uf
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 16:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146AbYDAONb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 10:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755150AbYDAONb
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 10:13:31 -0400
Received: from tan25.ncr.com ([192.127.94.25]:29504 "EHLO ncrusout3.NCR.COM"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754948AbYDAONa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2008 10:13:30 -0400
Received: from rpc7152.teradata.com (localhost [127.0.0.1])
	by ncrusout3.NCR.COM (8.13.8/8.13.8) with ESMTP id m31EDOZb002835
	for <git@vger.kernel.org>; Tue, 1 Apr 2008 10:13:29 -0400 (EDT)
Received: from susday7667.TD.teradata.com (localhost.localdomain [127.0.0.1])
	by rpc7152.teradata.com (8.13.8/8.13.8) with ESMTP id m31EDOoi019447
	for <git@vger.kernel.org>; Tue, 1 Apr 2008 10:13:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Trouble with initial fetch
Thread-Index: AciT+nFrGdquvtsERFq0uX5/MhSS+AACAomQ
X-imss-version: 2.050
X-imss-result: Passed
X-imss-scanInfo: M:B L:E SM:3
X-imss-tmaseResult: TT:1 TS:6.3750 TC:1F TRN:16 TV:5.0.1023(15822.007)
X-imss-scores: Clean:99.90000 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78657>



______________________________________________ 
From: 	Kristoff, Paul  
Sent:	Tuesday, April 01, 2008 9:15 AM
To:	git@vger.kernel.org
Cc:	Kristoff, Paul
Subject:	Trouble with initial fetch

I am trying to do an initial fetch from my svn repository and get the
following error:

>>> git-svn fetch -rxxx

... Lots of files are downloaded ...

W: +empty_dir: ...
W: +empty_dir: ...
W: +empty_dir: ...
error: invalid object 062537661a514c2ce97d18948f4f25f7226cc1a0
fatal: git-write-tree: error building trees
write-tree: command returned error: 128

I think I am near the end of the fetch.

Any ideas would be helpful.

Paul Kristoff
