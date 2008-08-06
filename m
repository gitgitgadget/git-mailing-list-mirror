From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: git show doesn't respect config: diff.renames=copies
Date: Wed, 6 Aug 2008 13:43:40 +0200
Message-ID: <20080806114340.GA24552@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 06 13:44:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQhRm-0008Fj-4k
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 13:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759847AbYHFLnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 07:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759589AbYHFLnq
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 07:43:46 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:59314 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759158AbYHFLnp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 07:43:45 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 23F195465; Wed,  6 Aug 2008 13:43:40 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91507>

What do I need to enter in /etc/gitconfig to get all commands that
deal with diffs of some kind to honour renames=copies ?
-- 
Sincerely,
           Stephen R. van den Berg.

If there's a hard way to do something, I'm there before anyone else.
