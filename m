From: Mike Gaffney <mr.gaffo@gmail.com>
Subject: update-server-info logic
Date: Tue, 28 Apr 2009 10:29:00 -0500
Message-ID: <49F720BC.9080604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 17:30:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LypFr-0002lj-W6
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 17:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932733AbZD1P3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 11:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbZD1P3L
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 11:29:11 -0400
Received: from pp0.asolutions.com ([66.236.120.143]:35222 "EHLO
	pp0.asolutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756978AbZD1P3I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 11:29:08 -0400
Received: from acews5.asolutions.com (acews5.asolutions.com [192.168.3.196])
	by pp0.asolutions.com (8.14.1/8.14.1) with ESMTP id n3SFT720002795
	for <git@vger.kernel.org>; Tue, 28 Apr 2009 10:29:07 -0500
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7400:2.4.4,1.2.40,4.0.166 definitions=2009-04-28_08:2009-04-28,2009-04-28,2009-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0811170000 definitions=main-0904280103
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117792>

Folks,
    I was wondering if someone could reply with a quick rundown of the 
update-server-info logic. I'm looking at implementing it in JGit and 
wanted to make sure I had it correct.

-Mike
