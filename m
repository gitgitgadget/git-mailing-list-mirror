From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: modifying commit's author
Date: Mon, 22 Jan 2007 15:37:34 -0500
Message-ID: <20070122203734.GB23187@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jan 22 21:37:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H95vA-0004RH-Fa
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 21:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbXAVUhg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 15:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbXAVUhg
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 15:37:36 -0500
Received: from mail.fieldses.org ([66.93.2.214]:40887 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932471AbXAVUhf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 15:37:35 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H95v4-0001XQ-Cd
	for git@vger.kernel.org; Mon, 22 Jan 2007 15:37:34 -0500
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37447>

If I got the author wrong on a commit, is there a quick way to fix it
(e.g. by passing the right arguments or environment variables to commit
--amend)?

--b.
