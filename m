From: Jeremy White <jwhite@codeweavers.com>
Subject: Re: [PATCH v2] Enable setting attach as the default in .gitconfig
 for git-format-patch.
Date: Sun, 08 Feb 2009 10:01:06 -0600
Message-ID: <498F01C2.5080105@codeweavers.com>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Sun Feb 08 17:30:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWCYD-0005Jb-6M
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 17:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbZBHQ2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 11:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbZBHQ2Z
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 11:28:25 -0500
Received: from jwhite-home.codeweavers.com ([209.240.253.22]:43744 "EHLO
	via.whitesen.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751717AbZBHQ2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 11:28:25 -0500
X-Greylist: delayed 1636 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Feb 2009 11:28:24 EST
Received: from myth.whitesen.org ([10.0.0.10])
	by via.whitesen.org with esmtp (Exim 4.69)
	(envelope-from <jwhite@codeweavers.com>)
	id 1LWC5i-0005VW-Ea; Sun, 08 Feb 2009 10:01:06 -0600
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <200902072310.12764.bss@iguanasuicide.net>
X-SA-Exim-Connect-IP: 10.0.0.10
X-SA-Exim-Mail-From: jwhite@codeweavers.com
X-SA-Exim-Scanned: No (on via.whitesen.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108990>

Boyd Stephen Smith Jr. wrote:
> For a minor style issue, see my reply to your original patch.

Sure, thanks.

> 
> Also, please read Documentation/SubmittingPatches.  Particularly, the third 
> point under the "Patch" heading on the first page.  Also, since you appear to 
> sympathize with Thunderbird users you might want to read the "Thunderbird" 
> section, and either improve it or petition the developers to make the 
> application more amenable to users needs in this case.

Sorry about that; I allowed my pleasure at the cuteness of using my own
patch to send the patch override the requested courtesy of this list.

As an aside, there is a long (and discouraging) read about the issue
with Thunderbird here:
  https://bugzilla.mozilla.org/show_bug.cgi?id=141983

Essentially, the problem is well understood - Thunderbird uses
format=flowed by default, which is what mangles the patches.  The author
of the relevant code is unmoved by arguments that the default should
switch, and no one has yet been willing to create a simpler UI for
switching the setting.

Cheers,

Jeremy
