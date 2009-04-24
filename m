From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: On "git status"
Date: Fri, 24 Apr 2009 13:24:18 +0200
Organization: Universitaetsklinikum Regensburg
Message-ID: <49F1BD85.16747.5FBF6DC@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 13:26:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxJXr-0001HT-H2
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 13:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbZDXLYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 07:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbZDXLYm
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 07:24:42 -0400
Received: from rrzmta1.rz.uni-regensburg.de ([194.94.155.51]:20682 "EHLO
	rrzmta1.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751230AbZDXLYl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2009 07:24:41 -0400
Received: from rrzmta1.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id DEF6CABDAC
	for <git@vger.kernel.org>; Fri, 24 Apr 2009 13:24:43 +0200 (CEST)
Received: from kgate1.dvm.klinik.uni-regensburg.de (kgate1.klinik.uni-regensburg.de [132.199.176.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta1.rz.uni-regensburg.de (Postfix) with ESMTP id D677BABD84
	for <git@vger.kernel.org>; Fri, 24 Apr 2009 13:24:43 +0200 (CEST)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by kgate1.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20070831MT-1) with ESMTP id n3OBOXUf005638
	for <git@vger.kernel.org>; Fri, 24 Apr 2009 13:24:33 +0200
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    24 Apr 09 13:24:30 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 24 Apr 09 13:24:18 +0100
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.37.0+V=4.37+U=2.07.219+R=05 January 2009+T=590375@20090424.112108Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117425>

Hi,

I'm unsure it exists already, but "git status" doesn't display the tracked files. 
Would it make sense to have those reported with a "git status -v" (for verbose)?
(You know: I'm thinking about "cvs status"...)

Regards,
Ulrich
