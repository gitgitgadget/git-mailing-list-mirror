From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] git.el: Use git-add-file for unmerged files, remove git-resolve-file
Date: Tue, 08 Sep 2009 20:43:38 +0200
Message-ID: <873a6x9t0l.fsf@wine.dyndns.org>
References: <4AA026AC.10907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin Nordholts <enselic@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 20:44:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml5fa-0004XG-Hy
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 20:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbZIHSns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 14:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbZIHSnr
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 14:43:47 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:33399 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbZIHSnr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 14:43:47 -0400
Received: from adsl-84-227-53-140.adslplus.ch ([84.227.53.140] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1Ml5fJ-0001U2-6G; Tue, 08 Sep 2009 13:43:49 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 0E4EE1E72DC; Tue,  8 Sep 2009 20:43:38 +0200 (CEST)
In-Reply-To: <4AA026AC.10907@gmail.com> (Martin Nordholts's message of "Thu,
	03 Sep 2009 22:27:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
X-Spam-Score: -3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128021>

Martin Nordholts <enselic@gmail.com> writes:

> Use `git-add-file' to mark unmerged files as resolved in the
> *git-status* buffer to be consistent with git's CLI instructions. Also
> remove `git-resolve-file' to make it clear that that "R" is a now a
> free keybinding.
>
> Signed-off-by: Martin Nordholts <martinn@src.gnome.org>

Looks good, thanks.

Acked-by: Alexandre Julliard <julliard@winehq.org>

-- 
Alexandre Julliard
julliard@winehq.org
