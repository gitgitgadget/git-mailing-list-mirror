From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: "SHA1" or "SHA-1"
Date: Fri, 24 Apr 2009 14:50:43 +0200
Organization: Universitaetsklinikum Regensburg
Message-ID: <49F1D1C6.9238.64B16D7@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 14:52:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxKtX-0006BE-UZ
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 14:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756042AbZDXMvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 08:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756395AbZDXMvJ
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 08:51:09 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([194.94.155.53]:10207 "EHLO
	rrzmta2.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756197AbZDXMvJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2009 08:51:09 -0400
Received: from rrzmta2.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 0C58FC5594
	for <git@vger.kernel.org>; Fri, 24 Apr 2009 14:51:11 +0200 (CEST)
Received: from kgate1.dvm.klinik.uni-regensburg.de (kgate1.klinik.uni-regensburg.de [132.199.176.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta2.rz.uni-regensburg.de (Postfix) with ESMTP id 03696C516D
	for <git@vger.kernel.org>; Fri, 24 Apr 2009 14:51:10 +0200 (CEST)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by kgate1.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20070831MT-1) with ESMTP id n3OCp0x8011560
	for <git@vger.kernel.org>; Fri, 24 Apr 2009 14:51:00 +0200
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    24 Apr 09 14:50:57 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 24 Apr 09 14:50:49 +0100
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.37.0+V=4.37+U=2.07.219+R=05 January 2009+T=590375@20090424.123742Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117434>

Hello,

I always thought, the official notation for "Secure Hash Algorithm #1" [FIPS-180-
1] was "SHA-1", and not "SHA1". However in the documentation I found many 
occurrencies of "SHA1". If someone is working on spelling errors, could that be 
changed?

Unfortunately RFC 3174 talks about "SHA-1" all the time, with the exception of the 
title that says: "US Secure Hash Algorithm 1 (SHA1)"...

Regards,
Ulrich
