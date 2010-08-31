From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Technical details about the index file format.
Date: Tue, 31 Aug 2010 00:59:14 +0000 (UTC)
Message-ID: <loom.20100831T025714-111@post.gmane.org>
References: <1202711335-12026-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 31 03:00:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqFCx-0001mD-34
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 03:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346Ab0HaBAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 21:00:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:40156 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756299Ab0HaBAG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 21:00:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OqFCn-0001ih-NH
	for git@vger.kernel.org; Tue, 31 Aug 2010 03:00:05 +0200
Received: from 72.14.229.1 ([72.14.229.1])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 03:00:05 +0200
Received: from srabbelier by 72.14.229.1 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 03:00:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 72.14.229.1 (Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/534.3 (KHTML, like Gecko) Chrome/6.0.472.51 Safari/534.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154873>

Heya,

Robin Rosenberg <robin.rosenberg <at> dewire.com> writes:
> 
> Signed-off-by: Robin Rosenberg <robin.rosenberg <at> dewire.com>
> ---
>  Documentation/technical/index-format.txt |   91 ++++++++++++++++++++++++++++++
>  1 files changed, 91 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/technical/index-format.txt

This pretty much got a LGTM from Junio back when it was sent [0], Robin, can you 
be persuaded to resend this? I think it'd be very good if we had some 
documentation on the index format.

[0] http://thread.gmane.org/gmane.comp.version-control.git/73471

--
Cheers,

Sverre Rabbelier
