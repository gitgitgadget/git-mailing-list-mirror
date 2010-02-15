From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Documentation: Fix indentation problem in git-commit(1)
Date: Mon, 15 Feb 2010 10:08:31 +0100
Message-ID: <201002151008.31980.trast@student.ethz.ch>
References: <1266194717-25438-1-git-send-email-jacob.helwig@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 10:09:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngwww-00082U-Ki
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 10:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab0BOJI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 04:08:56 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:4965 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158Ab0BOJIz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 04:08:55 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 15 Feb
 2010 10:08:52 +0100
Received: from thomas.localnet (213.55.131.185) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 15 Feb
 2010 10:08:35 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <1266194717-25438-1-git-send-email-jacob.helwig@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140002>

On Monday 15 February 2010 01:45:17 Jacob Helwig wrote:
> All options listed after "-u[<mode>], --untracked-files[=<mode>]" in the
> git-commit(1) manpage ended up listed as though they were part of the
> description for -u/--untracked-files.  This was introduced by d6293d1.

Wow.  I once spent something that felt like an hour fiddling with
different options and eventually just gave up without results.

I think the caveat

> I'm not entirely happy with this patch, since the "See linkgit..."
> paragraph does not retain its previous indentation level in the
> manpages, or HTML documentation.

should go into the commit message in some form, but it's definitely an
improvement either way.

So,

Acked-by: Thomas Rast <trast@student.ethz.ch>

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
