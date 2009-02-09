From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH v2] git-rebase-interactive: you can also add new commits 
	to the "work list"
Date: Mon, 9 Feb 2009 23:51:13 +0100
Message-ID: <adf1fd3d0902091451j27b06356oe626e909a691a0cd@mail.gmail.com>
References: <1234219494-20513-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Mon Feb 09 23:52:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWeza-0002ya-UD
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 23:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbZBIWvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 17:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752587AbZBIWvQ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 17:51:16 -0500
Received: from mu-out-0910.google.com ([209.85.134.190]:46987 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbZBIWvP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 17:51:15 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1266658mue.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 14:51:14 -0800 (PST)
Received: by 10.103.228.19 with SMTP id f19mr374209mur.32.1234219873766; Mon, 
	09 Feb 2009 14:51:13 -0800 (PST)
In-Reply-To: <1234219494-20513-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109156>

2009/2/9 Kjetil Barvik <barvik@broadpark.no>:
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 3d6d429..11eff32 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -318,8 +318,9 @@ Start it with the last commit you want to retain as-is:
>
>  An editor will be fired up with all the commits in your current branch
>  (ignoring merge commits), which come after the given commit.  You can
> -reorder the commits in this list to your heart's content, and you can
> -remove them.  The list looks more or less like this:
> +reorder the commits in this list to your heart's content, you can
> +remove them, and you can and new commits.  The list looks more or less
> +like this:

s/you can and/you can add/

Santi
