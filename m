From: Mark Burton <markb@smartavionics.com>
Subject: How to list versioned files with modification status
Date: Sat, 4 Oct 2008 13:12:56 +0100
Organization: Smart Avionics Ltd.
Message-ID: <20081004131256.586a5fbf@smartavionics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 04 23:20:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmEXI-00045W-Sh
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 23:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbYJDVSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 17:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbYJDVSZ
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 17:18:25 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:56894 "EHLO smtp.hosts.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069AbYJDVSY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 17:18:24 -0400
X-Greylist: delayed 32727 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Oct 2008 17:18:24 EDT
Received: from [86.128.74.78] (helo=smartavionics.com)
	by smtp.hosts.co.uk with esmtpa (Exim 4.69)
	(envelope-from <markb@smartavionics.com>)
	id 1Km60G-00031U-Gg
	for git@vger.kernel.org; Sat, 04 Oct 2008 13:12:56 +0100
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.9; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97477>


Hi,

I would like to be able to easily find those files in a git tree that
don't have pending modifications. Although ls-files can list the
files that are modified, it can't list those that aren't or list all
files with their modification status.

Thanks,

Mark

-- 

Smart Avionics Ltd. -- producer of innovative avionics for homebuilt
aircraft.
