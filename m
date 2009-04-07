From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH v2 10/14] difftool: add various git-difftool tests
Date: Tue, 7 Apr 2009 19:52:19 +0200
Message-ID: <200904071952.21109.markus.heidelberg@web.de>
References: <1239092483-14973-1-git-send-email-davvid@gmail.com> <1239092483-14973-3-git-send-email-davvid@gmail.com> <1239092483-14973-4-git-send-email-davvid@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, charles@hashpling.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 19:53:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrFUX-0000f2-DQ
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 19:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758059AbZDGRwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 13:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756809AbZDGRwJ
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 13:52:09 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:44225 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbZDGRwI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 13:52:08 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 336E1FC9E0EA;
	Tue,  7 Apr 2009 19:52:07 +0200 (CEST)
Received: from [89.59.110.219] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LrFSw-0002hR-00; Tue, 07 Apr 2009 19:52:06 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1239092483-14973-4-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+MSVqggxryYMWI1Vpp/9GrMpG9+lHnbuxD64uY
	Z2aOxT9zS61NisyW6EgjlHiMheRVLJKLhLIhQhPLbQ/TSSQ3jB
	sWgAxF+zplOSjBjx8I4w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115970>

David Aguilar, 07.04.2009:
> t7800-difftool.sh tests the various command-line flags,
> git-config variables, and environment settings supported by
> git-difftool.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> 
> The original broke the test suite on Mac OS.
> Testing difftool.<path>.path is hard without internal support
> for a fake tool.

Mac OS doesn't have the "echo" command?
