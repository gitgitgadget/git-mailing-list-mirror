From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Manual pages (from archive): no hyphenation
Date: Fri, 24 Apr 2009 13:22:11 +0200
Organization: Universitaetsklinikum Regensburg
Message-ID: <49F1BD06.32347.5FA078F@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 13:24:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxJVx-0000g3-KK
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 13:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbZDXLWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 07:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbZDXLWj
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 07:22:39 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([194.94.155.53]:28474 "EHLO
	rrzmta2.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751110AbZDXLWj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2009 07:22:39 -0400
Received: from rrzmta2.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 91DA7C5160
	for <git@vger.kernel.org>; Fri, 24 Apr 2009 13:22:39 +0200 (CEST)
Received: from kgate1.dvm.klinik.uni-regensburg.de (kgate1.klinik.uni-regensburg.de [132.199.176.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta2.rz.uni-regensburg.de (Postfix) with ESMTP id 89386C50E4
	for <git@vger.kernel.org>; Fri, 24 Apr 2009 13:22:39 +0200 (CEST)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by kgate1.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20070831MT-1) with ESMTP id n3OBMT4K005295
	for <git@vger.kernel.org>; Fri, 24 Apr 2009 13:22:29 +0200
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    24 Apr 09 13:22:26 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 24 Apr 09 13:22:20 +0100
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.37.0+V=4.37+U=2.07.219+R=05 January 2009+T=590375@20090424.112108Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117424>

Hello!

When using the manual pages that are shipped as archive, I noticed that some of 
them look a bit ugly, mostly because of the lack of hyphenation. If that wasn't 
intentional, could the proper commandy be added to the manual pages?

Also I've noticed that a signle quote is displayed (on my UTF-8 system) as "Z with 
an inverted roof" (i.e. a 'Z' with a vertically mirrored circumflex on top). That 
slooks somewhat strange.

Furthermose  In oticed that there is no manual page for git-status in the archive.

Regards,
Ulrich
