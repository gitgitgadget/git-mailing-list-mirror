From: Thomas Koch <thomas@koch.ro>
Subject: git notes primer?
Date: Tue, 10 Aug 2010 10:40:06 +0200
Message-ID: <201008101040.07172.thomas@koch.ro>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 10:40:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OikNf-00022k-4j
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 10:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333Ab0HJIkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 04:40:11 -0400
Received: from koch.ro ([88.198.2.104]:42848 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620Ab0HJIkK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 04:40:10 -0400
X-Greylist: delayed 655 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Aug 2010 04:40:10 EDT
Received: from 84-72-85-88.dclient.hispeed.ch ([84.72.85.88] helo=jona.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@koch.ro>)
	id 1OikAh-0008VT-BV
	for git@vger.kernel.org; Tue, 10 Aug 2010 10:26:55 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.32-4-amd64; KDE/4.4.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153082>

Hi,

I'm working on a patch management system as topgit, but without the 
complexity:
http://koch.ro/blog/index.php?/archives/139-tnt-is-not-topgit.html

Before I continue with my current design, I wanted to have a look at git 
notes, whether it would provide better mechanisms then tracking my meta 
informations in a hidden background branch. (Much like pristine-tar does.)

However I couldn't get a grip on git notes:

- Is git notes the only command that works on notes?
- How are notes saved inside GIT?
- Is git notes and it's implementation stable now?
- Are there any tutorials on workflows with git notes?
- What different use cases of git notes do you know?
- What use cases triggered the development of git notes in the first place?

Thank you for your time,

Thomas Koch, http://www.koch.ro
