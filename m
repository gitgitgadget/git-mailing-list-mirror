From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (Jul 2013, #07; Sun, 21)
Date: Mon, 22 Jul 2013 23:22:34 +0100
Message-ID: <20130722222234.GE2337@serenity.lan>
References: <7vy58zozdk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 00:22:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1OVF-0003MN-Gh
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 00:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459Ab3GVWWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 18:22:44 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:39077 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab3GVWWo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 18:22:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 52822CDA5D1;
	Mon, 22 Jul 2013 23:22:43 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ln0ou6bw44v5; Mon, 22 Jul 2013 23:22:42 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id B65A7CDA5B4;
	Mon, 22 Jul 2013 23:22:36 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vy58zozdk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231000>

On Sun, Jul 21, 2013 at 11:57:43PM -0700, Junio C Hamano wrote:
> * jk/fast-import-empty-ls (2013-06-23) 4 commits
>  - fast-import: allow moving the root tree
>  - fast-import: allow ls or filecopy of the root tree
>  - fast-import: set valid mode on root tree in "ls"
>  - t9300: document fast-import empty path issues
> 
>  Comments?

This originated with a user bug report [1] so I'd like to see it merged.

Any chance of some fast-import experts taking a look?

[1] http://article.gmane.org/gmane.comp.version-control.git/228586
