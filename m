From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [PATCH 1/3] rebase: fix typo (force_rebas -> force-rebas)
Date: Fri, 27 Mar 2009 19:58:00 +0100
Message-ID: <200903271958.00795.barra_cuda@katamail.com>
References: <1237399558-27289-1-git-send-email-barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 27 21:13:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnIQ8-0007JY-DZ
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 21:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762077AbZC0UJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 16:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761932AbZC0UJg
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 16:09:36 -0400
Received: from smtp.katamail.com ([62.149.157.154]:60376 "HELO smtp1.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1760110AbZC0UJf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 16:09:35 -0400
Received: (qmail 16014 invoked by uid 89); 27 Mar 2009 20:09:21 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO host98-56-dynamic.104-80-r.retail.telecomitalia.it) (barra?cuda@katamail.com@80.104.56.98)
  by smtp1-pc with SMTP; 27 Mar 2009 20:09:18 -0000
User-Agent: KMail/1.9.10
In-Reply-To: <1237399558-27289-1-git-send-email-barra_cuda@katamail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114923>

Just a reminder, since this patch was probably dropped.

On Wednesday 18 March 2009, Michele Ballabio wrote:
> Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
> ---
>  git-rebase.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-rebase.sh b/git-rebase.sh
> index d38ab0b..e38d68a 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -315,7 +315,7 @@ do
>  	--root)
>  		rebase_root=t
>  		;;
> -	-f|--f|--fo|--for|--forc|force|--force-r|--force-re|--force-reb|--force-reba|--force_rebas|--force-rebase)
> +	-f|--f|--fo|--for|--forc|force|--force-r|--force-re|--force-reb|--force-reba|--force-rebas|--force-rebase)
>  		force_rebase=t
>  		;;
>  	-*)
