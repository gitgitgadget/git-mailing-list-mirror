From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH] git-push: fix the documentation to explain all the
 status flags
Date: Mon, 8 Feb 2010 19:54:27 -0500
Message-ID: <20100209005427.GA18023@cthulhu>
References: <7vmxzj726j.fsf@alter.siamese.dyndns.org>
 <1265672654-26511-1-git-send-email-larry@elder-gods.org>
 <7veikv2r50.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 01:54:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeeN7-0003Py-QV
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 01:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab0BIAy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 19:54:28 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:35037 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899Ab0BIAy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 19:54:27 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 0F1258221DD; Mon,  8 Feb 2010 19:54:27 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7veikv2r50.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139344>

* Junio C Hamano (gitster@pobox.com) [100208 19:24]:
> Both [horizontal] and three colons are something we never have used in the
> existing documentation set.  How confident are you that various versions
> of deployed AsciiDoc people would use all support this?
> 
> I am not _complaining_; I am just being cautious to see if I have to look
> into the issue myself (if your answer is "not at all") or not (otherwise).

Apparently three colons is really new, its only in asciidoc 8.5.3, released this
January.  [horizontal] goes back to 8.3.0, from  2008.

          --arry
