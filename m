From: Zabre <427@free.fr>
Subject: Re: Force commit date
Date: Thu, 29 Jan 2009 10:45:09 -0800 (PST)
Message-ID: <1233254709681-2240602.post@n2.nabble.com>
References: <1233253817209-2240539.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 19:46:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSbuQ-0004Rm-OM
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 19:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbZA2SpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 13:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbZA2SpM
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 13:45:12 -0500
Received: from kuber.nabble.com ([216.139.236.158]:49854 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbZA2SpL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 13:45:11 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LSbsz-00072J-MG
	for git@vger.kernel.org; Thu, 29 Jan 2009 10:45:09 -0800
In-Reply-To: <1233253817209-2240539.post@n2.nabble.com>
X-Nabble-From: 427@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107710>


I'm wondering : maybe the trick is outside git? Maybe is it possible to
specify a "forced date" at which an action (a "git commit" in this case) is
done.
Some command that would wrap around the git commit command and tell the
system "apply this, but do it as if now was 2008-08-23 06:15:34".
What do you think?
This would be very interesting to know.
(btw I'm running Linux obviously)
-- 
View this message in context: http://n2.nabble.com/Force-commit-date-tp2240539p2240602.html
Sent from the git mailing list archive at Nabble.com.
