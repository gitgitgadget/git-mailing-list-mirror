From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 09/14] difftool: move 'git-difftool' out of contrib
Date: Tue, 7 Apr 2009 01:42:38 +0200
Message-ID: <200904070142.39026.markus.heidelberg@web.de>
References: <1239006689-14695-1-git-send-email-davvid@gmail.com> <1239006689-14695-9-git-send-email-davvid@gmail.com> <1239006689-14695-10-git-send-email-davvid@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, charles@hashpling.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 01:44:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqyTx-00071D-90
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 01:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbZDFXm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 19:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbZDFXm3
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 19:42:29 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:54976 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbZDFXm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 19:42:28 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 77F17FA0DDD4;
	Tue,  7 Apr 2009 01:42:26 +0200 (CEST)
Received: from [89.59.82.208] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LqySQ-000127-00; Tue, 07 Apr 2009 01:42:26 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1239006689-14695-10-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/lXdlyK3Vrqoh/bKwfPKbFv7g/gW4ZjvkdOd2z
	2zH1TdguIB3GWHl7Wv3jTnQCFBc+suc6WEfIh1510Sp4DOLH94
	EO2Hv8qszkEHF9R0zBVw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115894>

David Aguilar, 06.04.2009:
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> +diff.tool::
> +	Controls which diff tool is used.  `diff.tool` overrides
> +	`merge.tool` when used by linkgit:git-difftool[1] and has
> +	the same valid values as `merge.tool`.

+kompare
-tortoisemerge
