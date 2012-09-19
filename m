From: Torsten Louland <torsten.louland@telenet.be>
Subject: Git 1.7.12 installer blocked by Gatekeeper - needs signing with an Apple developer ID
Date: Wed, 19 Sep 2012 07:59:43 +0200
Message-ID: <954DDAEA-30AF-4203-BD49-3AB163E4EF58@telenet.be>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1486\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 19 07:59:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEDKG-0005fD-3u
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 07:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab2ISF7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 01:59:47 -0400
Received: from juliette.telenet-ops.be ([195.130.137.74]:34654 "EHLO
	juliette.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352Ab2ISF7q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Sep 2012 01:59:46 -0400
Received: from [10.0.1.7] ([94.226.245.181])
	by juliette.telenet-ops.be with bizsmtp
	id 0tzk1k0053vZHKS06tzktD; Wed, 19 Sep 2012 07:59:44 +0200
X-Mailer: Apple Mail (2.1486)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205908>

Hi,

Installing latest stable git on Mac OS X Mountain Lion is blocked by Gatekeeper.

Could you provide an installer for latest stable git that is signed with an Apple issued developer ID so gatekeeper will let it through?

I upgraded to Mountain Lion and decided to update git as well, but only found out about the installer incompatibility after I'd run the uninstall script on my previous version.

For a while I was gitless and witless until I discovered you can bypass gatekeeper by opening the package with Installer.app - was just a bit stressful.

Cheers,
Torsten Louland
