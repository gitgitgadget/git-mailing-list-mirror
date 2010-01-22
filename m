From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH 1/1] Random documentation spelling fixes
Date: Fri, 22 Jan 2010 09:36:14 +0100
Message-ID: <20100122083614.GE7370@headley>
References: <1264126491-8273-1-git-send-email-vonbrand@inf.utfsm.cl>
 <1264126491-8273-2-git-send-email-vonbrand@inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Fri Jan 22 09:42:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYF5b-0000r0-0B
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 09:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab0AVIly convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jan 2010 03:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752112Ab0AVIly
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 03:41:54 -0500
Received: from mail-fx0-f223.google.com ([209.85.220.223]:61182 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab0AVIlx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 03:41:53 -0500
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Jan 2010 03:41:52 EST
Received: by fxm23 with SMTP id 23so1025537fxm.38
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 00:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gh4g0RqjCWfqkybAWh8KMuUZZs4BFryMIm7Sa+IP5pE=;
        b=TZ8G0RHyXhgvm/rAEbQ33Fm6GrKPshuNV5cBDWQ9gwesqUTvTEbp2tHiFZC976JePa
         409+7E4CMj7ZVrmFBvXU6ZqMeOy6PfIRIdzhM+PrZPdLDtbD+Ujbsyqx7bM2joVmTQMF
         44InpWhFApRqaP8krpLf4ZNHtQgJGh3yJyFxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=DQ7gMkMAeYV5kllKmobcXadt3v76ZuotIDHTGAscubmE8jLBsod9B+Na+bwRd4cm3x
         OF/y5MZNc4hBnKPXpbSrp6Ihgn4h0ha+YFNIFrjL3LRGWtI8YcFgO67yvPC7jCMEPPAb
         AQK0BGuZFh88bzYfQ+mh+h59+q38C51fyG4/0=
Received: by 10.223.76.77 with SMTP id b13mr2567492fak.74.1264149231734;
        Fri, 22 Jan 2010 00:33:51 -0800 (PST)
Received: from localhost ([88.103.132.186])
        by mx.google.com with ESMTPS id f31sm2517843fkf.42.2010.01.22.00.33.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Jan 2010 00:33:51 -0800 (PST)
Mail-Followup-To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <1264126491-8273-2-git-send-email-vonbrand@inf.utfsm.cl>
User-Agent: Mutt/1.5.20 (2009-08-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137747>

Cool!

On Thu, Jan 21, 2010 at 11:14:51PM -0300, Horst H. von Brand wrote:
> =20
>   * "git fast-export" did not export octopus merges correctly.
> diff --git a/Documentation/RelNotes-1.5.6.txt b/Documentation/RelNote=
s-1.5.6.txt
> index e143d8d..0614225 100644
> --- a/Documentation/RelNotes-1.5.6.txt
> +++ b/Documentation/RelNotes-1.5.6.txt
> @@ -25,7 +25,7 @@ Updates since v1.5.5
>  * Many freestanding documentation pages have been converted and made
>    available to "git help" (aka "man git<something>") as section 7 of
>    the manual pages. This means bookmarks to some HTML documentation
> -  files may need to be updated (eg "tutorial.html" became
> +  files may need to be updated (eg, "tutorial.html" became
>    "gittutorial.html").

What about "e.g.", when you're at it? (And I don't think the comma is
necessary -- and you didn't add it in the very first hunk of the patch
anyway).

> diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-=
bisect-lk2009.txt
> index 6b7b2e5..eb35f2f 100644
> --- a/Documentation/git-bisect-lk2009.txt
> +++ b/Documentation/git-bisect-lk2009.txt
> @@ -1320,7 +1320,7 @@ So git bisect is unconditional goodness - and f=
eel free to quote that
>  ;-)
>  _____________
> =20
> -Acknowledgements
> +Acknowledgments
>  ----------------

Both are correct, AFAIK.


Regards,

    =C5=A0t=C4=9Bp=C3=A1n
