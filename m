From: Bill Lear <rael@zopyra.com>
Subject: What did I just fetch?
Date: Wed, 31 Jan 2007 06:55:23 -0600
Message-ID: <17856.37307.324767.617892@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 13:55:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCEzq-0005I7-Lm
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 13:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933207AbXAaMz1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 07:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933217AbXAaMz1
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 07:55:27 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60945 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933207AbXAaMz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 07:55:27 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0VCtQI01978;
	Wed, 31 Jan 2007 06:55:26 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38243>

When updating in cvs, I get a list of files changed by the update.

How can I do this in git when fetching into a bare repo?

% GIT_DIR=. git fetch git://source/project
remote: Generating pack...
remote: Done counting 18 objects.
remote: Result has 10 objects.
remote: Deltifying 10 objects.
remote:  100% (10/10) done
Unpacking 10 objects
remote: Total 10, written 10 (delta 6), reused 7 (delta 3)
 100% (10/10) done

So, I'd like to see the files, perhaps the differences, etc.


Bill
