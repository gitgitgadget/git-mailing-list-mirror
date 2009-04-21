From: Cameron Westland <cameron@bigbangtechnology.com>
Subject: Add support for adding recursive submodules
Date: Tue, 21 Apr 2009 17:27:02 -0400
Message-ID: <8A1CB4B1-DC22-4E44-A519-CC0A79BE7018@bigbangtechnology.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 21 23:35:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwNcd-0004vu-04
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 23:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757928AbZDUVdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 17:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757506AbZDUVdp
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 17:33:45 -0400
Received: from battlescripters.com ([72.47.201.172]:57126 "EHLO
	battlescripters.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673AbZDUVdp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 17:33:45 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Apr 2009 17:33:44 EDT
Received: (qmail 26396 invoked from network); 21 Apr 2009 14:27:03 -0700
Received: from 206-248-158-235.dsl.teksavvy.com (HELO cam-mac.lan) (206.248.158.235)
  by battlescripters.com with SMTP; 21 Apr 2009 14:27:03 -0700
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117159>

Hey,

I'd like to give a +1 to adding recursive support for submodules. I'm  
trying to add submodule repositories to my current repository and they  
have submodules. I can't figure out how to do this without some sort  
of recursive option.

Thanks,
Cameron
