From: "Greg Lee" <glee@swspec.com>
Subject: Selecting the minor revs
Date: Mon, 27 Mar 2006 18:49:53 -0500
Message-ID: <0e6701c651f9$2605aad0$a100a8c0@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Mar 28 01:52:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO1VH-0002cu-E4
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 01:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWC0Xv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 18:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWC0Xv7
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 18:51:59 -0500
Received: from mail.vtacs.com ([207.42.84.219]:57004 "EHLO mail.vtacs.com")
	by vger.kernel.org with ESMTP id S932093AbWC0Xv6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Mar 2006 18:51:58 -0500
Received: from GregDesktop (e242.vtacs.com [207.42.84.242])
	by mail.vtacs.com (8.13.6/8.13.3) with ESMTP id k2RNppCk006223
	for <git@vger.kernel.org>; Mon, 27 Mar 2006 18:51:56 -0500
To: <git@vger.kernel.org>
X-Mailer: Microsoft Office Outlook 11
x-mimeole: Produced By Microsoft MimeOLE V6.00.2900.2670
Thread-Index: AcZR+STPXtfQgq3eSem0+CRgTvSQ9g==
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18089>

How do I select one of the "minor" bug fix revs using git?  For example I want to do a git
bisect between 2.6.15.6 and 2.6.16 but I cannot determine what the naming convention is
for "2.6.15.6".  I've tried "v2.6.15.6" and "v2.6.15-6".
 
Please cc any responses.

Thanks,
Greg Lee
