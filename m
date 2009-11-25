From: Yann Dirson <ydirson@linagora.com>
Subject: [egit] Git repository with multiple eclipse projects ?
Date: Wed, 25 Nov 2009 17:47:34 +0100
Message-ID: <20091125164734.GF21347@linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 18:30:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDLhE-0003N5-B6
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 18:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754445AbZKYR3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 12:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753346AbZKYR3o
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 12:29:44 -0500
Received: from [194.206.158.221] ([194.206.158.221]:34853 "EHLO
	cyann.linagora.lan" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753217AbZKYR3n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 12:29:43 -0500
X-Greylist: delayed 2534 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2009 12:29:43 EST
Received: from yann by cyann.linagora.lan with local (Exim 4.69)
	(envelope-from <yann@linagora.com>)
	id 1NDL1i-0002nu-Fu
	for git@vger.kernel.org; Wed, 25 Nov 2009 17:47:34 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133653>

I am investigating whether it is possible at all to have several
eclipse projects in a single git repo, and have those projects
correctly seen as managed by git.

When importing a git repo into eclipse, we get a list of projects to
import, but that list is empty.  What is expected by egit to get this
list filled ?

It also does not look like it would be possible to use the "share"
functionnality to setup such a repository from multiple projects (or
from a project set), right ?

Best regards,
-- 
Yann
