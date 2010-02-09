From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH] git-push: fix the documentation to explain all the
 status flags
Date: Mon, 8 Feb 2010 19:56:22 -0500
Message-ID: <20100209005622.GB18023@cthulhu>
References: <7vmxzj726j.fsf@alter.siamese.dyndns.org>
 <1265672654-26511-1-git-send-email-larry@elder-gods.org>
 <7veikv2r50.fsf@alter.siamese.dyndns.org>
 <7vaavj2qu1.fsf@alter.siamese.dyndns.org>
 <7vk4un1bku.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 01:56:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeeP6-0004Ys-Dn
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 01:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435Ab0BIA4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 19:56:24 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:55069 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046Ab0BIA4X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 19:56:23 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id CD5918221DD; Mon,  8 Feb 2010 19:56:22 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vk4un1bku.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139345>

* Junio C Hamano (gitster@pobox.com) [100208 19:45]:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Unfortunately, http://www.methods.co.nz/asciidoc/newlists.html labels the
> > syntax as "new in 8.3.0", and Debian 5.0.X and Fedora 11 both use AsciiDoc
> > that are older than that (8.2.7 and 8.2.5).
> >
> > I'll flatten the description into prose for now.
> 
> Actually, we  already use another syntax for nested enumerations, namely
> double-semicolon, in config.txt, so let's mimic that.
> 
> -- >8 --
> Subject: git-push: document all the status flags used by --porcelain output 

the flags are used by normal git-push as well

    --larry
