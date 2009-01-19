From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH v2] contrib: add 'git-difftool' for launching common diff tools
Date: Mon, 19 Jan 2009 05:45:32 +0100
Message-ID: <200901190545.33141.markus.heidelberg@web.de>
References: <200901182025.24045.markus.heidelberg@web.de> <1232324753-16137-1-git-send-email-davvid@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 05:46:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOm1W-0003jV-W0
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 05:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876AbZASEon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 23:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754772AbZASEon
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 23:44:43 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:41200 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764AbZASEom (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 23:44:42 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 70810F90A692;
	Mon, 19 Jan 2009 05:44:41 +0100 (CET)
Received: from [89.59.93.106] (helo=pluto.local)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LOm09-0000bl-00; Mon, 19 Jan 2009 05:44:41 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <1232324753-16137-1-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+zcIh38+/esq+NrZ+qWvRp83TfhmU6SxUb3ts4
	GFfxN9BoXlX2yebCykwEvozWPWfMCbdcKzkwS/URQGddBzL5Y3
	A18dbpp9SGcf0lUHr9rg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106320>

David Aguilar, 19.01.2009:
> 'git-difftool' is a git command that allows you to compare and edit files
> between revisions using common merge tools.  'git-difftool' does what
> 'git-mergetool' does but its use is for non-merge situations such as
> when preparing commits or comparing changes against the index.
> It uses the same configuration variables as 'git-mergetool' and
> provides the same command-line interface as 'git-diff'.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> 
> This newer version addresses the feedback from Markus Heidelberg.
> difftool is now more consistent with mergetool and it includes
> Markus's vimdiff enhancements for positioning the cursor at startup.

Your patch is already in master, you should send a patch against it.

Markus
