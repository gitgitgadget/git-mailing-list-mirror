From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 0/3] http*: refactor fetching code (v2)
Date: Fri, 22 May 2009 10:34:42 +0200
Message-ID: <20090522083442.GA30571@localhost>
References: <20090518163025.58842505.rctay89@gmail.com> <20090520074352.GC21455@glandium.org> <alpine.DEB.1.00.0905201220270.16461@intel-tinevez-2-302> <be6fef0d0905200514p55317a80ra765f6027f47c339@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 10:35:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7QDb-0000jo-Lu
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 10:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbZEVIe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 04:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbZEVIe5
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 04:34:57 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:35108 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbZEVIe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 04:34:56 -0400
Received: from darc.dyndns.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 22 May 2009 10:34:56 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1M7QDC-0007zH-KF; Fri, 22 May 2009 10:34:42 +0200
Content-Disposition: inline
In-Reply-To: <be6fef0d0905200514p55317a80ra765f6027f47c339@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 22 May 2009 08:34:56.0927 (UTC) FILETIME=[2FE6EAF0:01C9DAB8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119720>

On Wed, May 20, 2009 at 08:14:59PM +0800, Tay Ray Chuan wrote:
> a quick list of tests available for http* (I left out some minor ones):
[...]
> 
> Mike and Johannes, what else do you have in mind?

As I understand it, there is a bunch of error regressions in Mike's patches.
Having tests for those would help.
