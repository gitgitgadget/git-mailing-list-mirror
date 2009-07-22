From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Why is it important to learn git?
Date: Wed, 22 Jul 2009 09:52:26 +0200
Message-ID: <200907220952.27385.trast@student.ethz.ch>
References: <e1a5e9a00907212208t10a071d0oe59a39b357a1111a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tim Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 09:53:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTWdL-0002p8-0g
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 09:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332AbZGVHwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 03:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753618AbZGVHwe
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 03:52:34 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:24403 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752802AbZGVHwe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 03:52:34 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 22 Jul 2009 09:52:32 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 22 Jul 2009 09:52:32 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.23-0.1-default; KDE/4.2.96; x86_64; ; )
In-Reply-To: <e1a5e9a00907212208t10a071d0oe59a39b357a1111a@mail.gmail.com>
X-OriginalArrivalTime: 22 Jul 2009 07:52:32.0600 (UTC) FILETIME=[5E902D80:01CA0AA1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123744>

Tim Harper wrote:
> 
> How has mastering the advanced features of git helped you to be a
> better programmer?

I came from SVN, and I guess the most important change for me was:

  Learning to make nice, reviewable, working, one-change-per-revision
  commits.

This must be enforced by social pressure of course, but 'add --patch',
'commit --amend', 'rebase --interactive' and some others make it very
easy to actually do it even when working on a series of changes.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
