From: "Tim Harper" <timcharper@gmail.com>
Subject: Re: [PATCH] added OS X package downloads
Date: Thu, 3 Apr 2008 23:58:33 -0600
Message-ID: <e1a5e9a00804032258w6b5af640l908bc6be71b28fd1@mail.gmail.com>
References: <1207288511-19478-1-git-send-email-timcharper@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 04 07:59:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhexK-0001EF-NB
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 07:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbYDDF6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 01:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbYDDF6f
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 01:58:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:53570 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbYDDF6e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 01:58:34 -0400
Received: by fg-out-1718.google.com with SMTP id l27so3686696fgb.17
        for <git@vger.kernel.org>; Thu, 03 Apr 2008 22:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=n0GAnCJWa1anW/vXmxFMa+++27DP8YZcLHI0UfNy+tw=;
        b=MZIPu/ClI9EtOhmQUh7EsXsHT5caaz9d14u9AnbfQqAoUUgZJHSTSGb+cdgLBFMTkK1lz8g2Uv5Zvs4w4tt875JzFU8SPbyQOxenVFeeHtm8a4rFADKqXwA7pO31PmQA/m75qPXvOa1SfW2/gkl6oWCm6KipCTCtWUzatfPXOfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n7lfvsXsvmt4YrwnLfU2h0vYzGZx5sT39kq/Q9dQ4EujEN4IbwU7o1w5ZLBvvsjmrFHtUOX0dTcs1ANJr/7HPniM+jnsjqd+/K215MZLN2P1ZwAkQxsoq5Y3u3uFJeylfSt1JynhlpOHYrHF2jGH1BznJjGP4NJwBGxMOh6OyNk=
Received: by 10.86.84.5 with SMTP id h5mr511796fgb.53.1207288713312;
        Thu, 03 Apr 2008 22:58:33 -0700 (PDT)
Received: by 10.86.84.2 with HTTP; Thu, 3 Apr 2008 22:58:33 -0700 (PDT)
In-Reply-To: <1207288511-19478-1-git-send-email-timcharper@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78793>

This is a patch for git.or.cz, and meant for Petr Baudis

Thanks,
Tim

On Thu, Apr 3, 2008 at 11:55 PM, Tim Harper <timcharper@gmail.com> wrote:
> ---
>  index.html |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/index.html b/index.html
> index 5b7e281..afe6e13 100644
> --- a/index.html
> +++ b/index.html
> @@ -246,6 +246,14 @@ You can also use one of many <a href="http://www.kernel.org/mirrors/">kernel.org
>  <td><a href="http://code.google.com/p/msysgit/downloads/list">http://code.google.com/p/msysgit/downloads/list</a></td>
>  </tr>
>
> +<tr class="odd">
> +<td rowspan="3">OS X</td>
> +</tr>
> +<tr>
> +<td>Stable</td>
> +<td><a href="http://code.google.com/p/git-osx-installer/downloads/list?can=3&q=&sort=-uploaded&colspec=Filename+Summary+Uploaded+Size+DownloadCount">http://code.google.com/p/git-osx-installer/downloads/list?can=3</a></td>
> +</tr>
> +
>  </table>
>
>  <h3>Development snapshots</h3>
> --
> 1.5.4.5
>
>
