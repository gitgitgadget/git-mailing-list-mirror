From: "Vitaly V. Ch" <vitaly.v.ch@gmail.com>
Subject: Re: Fwd: Bug in StackedGit
Date: Tue, 15 Apr 2008 10:46:38 +0000
Message-ID: <6efe08af0804150346u4e3fc383y90dca9a723818d63@mail.gmail.com>
References: <6efe08af0804150301t9f4a1dbte564902736ebc302@mail.gmail.com>
	 <6efe08af0804150306x1075970cxd6c9bed3dd0a6394@mail.gmail.com>
	 <20080415103854.GA31188@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 15 12:47:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlihA-00078o-OS
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 12:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbYDOKqk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2008 06:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755556AbYDOKqj
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 06:46:39 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:41476 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbYDOKqj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Apr 2008 06:46:39 -0400
Received: by yw-out-2324.google.com with SMTP id 5so932551ywb.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 03:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Xk7ISFShSz5++oPtY0bez1VXE1spl73PPXUZciNxDug=;
        b=MYIogPffdBKIGg1SbPpaaNerFPylr2XWt2qrGStNgIAzhKOfYACeO/fA/F90VwvIm07GfHwvrFzfEnMl/zbdsuyVMm+gi6bNQiExPigelW0pBH0Wr6OIL9ujEuwkaV03fdOo/OpPyUV9nrZSt8GfjSSGwiWLBjf9dj4C/TjADUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=USWANqwcqC+fP0eGA+GoWthEgtf7+yYuNaQq8IVF4aMsqSMW3fR/w4JrTLMOfqoO8MnpdQYYdbaMgKzfQ0V0c8zR0yk+MfNn1jN4vrB0Xedsz5cvHmNLwqbgsMbQFhDoZw7sETxkizyWsSKjT/g2Eg458Kx36SfN/92bfXjvT/c=
Received: by 10.151.112.5 with SMTP id p5mr7533871ybm.120.1208256398873;
        Tue, 15 Apr 2008 03:46:38 -0700 (PDT)
Received: by 10.150.229.1 with HTTP; Tue, 15 Apr 2008 03:46:38 -0700 (PDT)
In-Reply-To: <20080415103854.GA31188@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79582>

On Tue, Apr 15, 2008 at 10:38 AM, Karl Hasselstr=F6m <kha@treskal.com> =
wrote:
> On 2008-04-15 10:06:43 +0000, Vitaly V. Ch wrote:
>
>  > after stg commit all patch history is loss. It's sucks. there are
>  > nothing lost in bzr loom .
>
>  I assume you refer to the patch history shown by "stg log"?
Yes. There are sometimes sens to revert some patch after commit to
previous version.

\\wbr Vitaly Chernookiy

>
>  I'm working on a new and improved patch log/undo thingy for StGit,
>  which doesn't lose the history of your patches when they are deleted=
=2E
>  Thanks to constructive feedback such as this, it'll be completed in =
no
>  time. ;-)
>
>  --
>  Karl Hasselstr=F6m, kha@treskal.com
>       www.treskal.com/kalle
>
