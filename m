From: Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH] Documentation: reword rebase summary
Date: Wed, 2 Mar 2016 00:16:48 +0100
Message-ID: <20160301231648.GA26165@ikke.info>
References: <1456872598-32571-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pdewulf@lyra-network.com, gitster@pobox.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 00:16:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aatXD-0007fQ-2p
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 00:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbcCAXQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 18:16:50 -0500
Received: from ikke.info ([178.21.113.177]:43778 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878AbcCAXQu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 18:16:50 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
	id 8EE932D8007; Wed,  2 Mar 2016 00:16:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1456872598-32571-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288078>

On Tue, Mar 01, 2016 at 02:49:58PM -0800, Stefan Beller wrote:
> The wording is introduced in c3f0baaca (Documentation: sync git.txt
> command list and manual page title, 2007-01-18), but rebase has evolved
> since then, capture the modern usage by being more generic about the
> rebase command in the summary.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
>  Inspired by
>  https://medium.freecodecamp.com/git-rebase-and-the-golden-rule-explained-70715eccc372
>  (I tried to cc the author, but I am not sure if I got the right email address)
>  
>  Thanks,
>  Stefan
> 
>  Documentation/git-rebase.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 6cca8bb..6ed610a 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -3,7 +3,7 @@ git-rebase(1)
>  
>  NAME
>  ----
> -git-rebase - Forward-port local commits to the updated upstream head
> +git-rebase - Reapply commits on top of another base tip
>  
>  SYNOPSIS
>  --------
> -- 
> 2.8.0.rc0
> 

I was thinking about doing the same. Thanks for improving this.
