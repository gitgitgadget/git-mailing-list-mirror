From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: cvs diff -l equivalent?
Date: Wed, 30 Jul 2008 10:20:30 +0200
Message-ID: <20080730082030.GA12555@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 10:21:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO6wA-00071c-Pi
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 10:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbYG3IUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 04:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbYG3IUd
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 04:20:33 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:57212 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbYG3IUc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 04:20:32 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id ED2C55466; Wed, 30 Jul 2008 10:20:30 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90757>

Someone popped this question on me.  The closest I got was:

   git diff .

But that still recurses.  Any solutions without patching?
-- 
Sincerely,
           Stephen R. van den Berg.

How many weeks are there in a lightyear?
