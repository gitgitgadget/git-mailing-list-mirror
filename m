From: Thomas Koch <thomas@koch.ro>
Subject: git am fails to add new files
Date: Tue, 2 Feb 2010 16:07:25 +0100
Message-ID: <201002021607.25719.thomas@koch.ro>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 16:26:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcKeQ-0005PA-K7
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 16:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756283Ab0BBP0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 10:26:44 -0500
Received: from koch.ro ([88.198.2.104]:48936 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756149Ab0BBP0n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 10:26:43 -0500
X-Greylist: delayed 1150 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2010 10:26:43 EST
Received: from 84-72-85-88.dclient.hispeed.ch ([84.72.85.88] helo=jona.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@koch.ro>)
	id 1NcKBe-0007jT-Ni
	for git@vger.kernel.org; Tue, 02 Feb 2010 15:57:07 +0100
User-Agent: KMail/1.12.4 (Linux/2.6.31-1-amd64; KDE/4.3.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138723>

Hi,

I'm using GIT on Debian unstable (1.6.6.1). When applying patches I created 
with git format-patch and applying them afterwards with git am, this fails 
with every patch that adds a new file.
Is there any option I forgot to give to git am? Or is this a bug.

Best regards,

Thomas Koch, http://www.koch.ro
