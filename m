From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: gitk: (un)interesting files/hunks diffs
Date: Thu, 15 Dec 2005 16:24:21 +0100
Message-ID: <8764pqtmca.fsf@ifae.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Dec 15 16:25:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmuwX-00042R-4E
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 16:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVLOPWg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 10:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVLOPWg
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 10:22:36 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:63188 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1750708AbVLOPWf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Dec 2005 10:22:35 -0500
Received: from bela (l9.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id jBFFMYJ20868
	for <git@vger.kernel.org>; Thu, 15 Dec 2005 16:22:34 +0100
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13699>

Hello *,

      when viewing a merge diff in gitk it discards all files that merge
      cleanly (the whole file). It could be usefull to list the files in the
      file list with the color of the corresponding "winning" parent.

      Another thing that could be usefull is to make the (un)interesting
      test at the hunk level, so you could clearly see only the edits
      made manually during the merge.

      Thanks.

      Santi

-- 
Looking for signature...
Looking for signature...done
