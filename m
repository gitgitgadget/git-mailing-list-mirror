From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Prompt for merge message?
Date: Thu, 6 Oct 2011 22:19:07 +0200
Message-ID: <20111006201907.GA27744@inner.h.iocl.org>
References: <6eb7acc7-f4be-4b90-a2fa-a0c91ed9a5a8@t11g2000yqk.googlegroups.com> <20111006182534.GA13628@vfa-6h>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Todd A. Jacobs" <nospam+listmail@codegnome.org>,
	git@vger.kernel.org
To: Jacob Helwig <jacob@technosorcery.net>
X-From: git-owner@vger.kernel.org Thu Oct 06 22:19:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBuPX-0002uC-CZ
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 22:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756993Ab1JFUTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 16:19:14 -0400
Received: from continuum.iocl.org ([217.140.74.2]:57419 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756902Ab1JFUTO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 16:19:14 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id p96KJ8c27903;
	Thu, 6 Oct 2011 22:19:08 +0200
Content-Disposition: inline
In-Reply-To: <20111006182534.GA13628@vfa-6h>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183023>

On Thu, 06 Oct 2011 11:25:34 +0000, Jacob Helwig wrote:
> "git merge --no-ff --no-commit branch_foo && git commit" ?

"git merge --no-ff branch_foo && git commit --amend"

Andreas
