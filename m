From: Thomas Koch <thomas@koch.ro>
Subject: How to fork
Date: Tue, 12 Aug 2008 10:30:21 +0200
Organization: Young Media Concepts
Message-ID: <200808121030.21384.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 10:32:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSpIZ-0006mc-IX
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 10:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbYHLIbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 04:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbYHLIbI
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 04:31:08 -0400
Received: from koch.ro ([195.34.83.107]:57951 "EHLO
	ve825703057.providerbox.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751466AbYHLIbH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Aug 2008 04:31:07 -0400
X-Greylist: delayed 1239 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Aug 2008 04:31:07 EDT
Received: from 217-162-251-183.dclient.hispeed.ch ([217.162.251.183] helo=jona.local)
	by ve825703057.providerbox.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <thomas@koch.ro>)
	id 1KSpH0-00026c-RW
	for git@vger.kernel.org; Tue, 12 Aug 2008 10:30:36 +0200
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-Spam_score: -2.3
X-Spam_score_int: -22
X-Spam_bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92077>

Hi,

I just wonder, that neither the official Git manual, nor the kernel
hackers guide to git describe the best practice to fork a project.

My use case: There is an existing git repo

git clone http://git.el-tramo.be/wigit.git

which I want to fork. The original code should live in a separate branch
in my local git repo (not master) so that I can still merge in changes.

The result of my changes should be posted to my server.

Could somebody be so kind to show me the list of commands which I'd
need?

Thanks a lot,
-- 
Thomas Koch, Software Developer
http://www.koch.ro

Young Media Concepts GmbH
Sonnenstr. 4
CH-8280 Kreuzlingen
Switzerland

Tel    +41 (0)71 / 508 24 86
Fax    +41 (0)71 / 560 53 89
Mobile +49 (0)170 / 753 89 16
Web    www.ymc.ch
