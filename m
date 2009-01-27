From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: friendlier names
Date: Tue, 27 Jan 2009 17:33:23 +0200
Message-ID: <94a0d4530901270733q222a6181k25b1da91b35e72d4@mail.gmail.com>
References: <87mydc6a2r.fsf@mcbain.luannocracy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 16:35:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRpxl-0000iG-4T
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 16:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbZA0Pd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 10:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbZA0Pd0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 10:33:26 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:39572 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbZA0PdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 10:33:25 -0500
Received: by ewy14 with SMTP id 14so1856711ewy.13
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 07:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7t5qEF92mKhzpkAtnSsDUSRB8zNiLAOoX7e+D2/DtlU=;
        b=YHkkh6RrAJzIEBAmSflxGaSnaJ2q6+L4diEIusPAbzHsMih2cELLqiwWpZlNF0jtHj
         ABzqbtRcqA5NSbgXgi9VzGpHOh4RZDWFyWRgbIkuyBGjKgIGOW/UNNH1aOarPj5CboUt
         4C/XHBft0zsJFVaxY34l7GusFTWpfE/S79MVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jr8AK3rbC2WKNgL7DDEgSlv0z5FwCy4k7NMslT922jWeXPDZ2Xhk0tWh6sgIDiblK7
         mdXII4/z2v8aSlG9bVQ2KY9g6dbSCWK1ukPAyJJPwJq1gbF6wKasm/Vgr7m4D5DuwwMo
         vi61ulRpSHk/LACABEyYvfWmAPFVQWfEGBbDo=
Received: by 10.86.53.8 with SMTP id b8mr496042fga.13.1233070403113; Tue, 27 
	Jan 2009 07:33:23 -0800 (PST)
In-Reply-To: <87mydc6a2r.fsf@mcbain.luannocracy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107354>

On Tue, Jan 27, 2009 at 5:30 PM, David Abrahams <dave@boostpro.com> wrote:
>
> I'm absolutely certain I'm not the first person to have raised this
> issue, so feel free to point me at the threads where I can get the
> rationale... but: to me it looks like git's choice of terminology hurts
> its adoption and learnability.
>
> For example, why couldn't the "index" be called the "stage" instead?
> That, along with knowing that "git add" was a synonym for "git stage"
> would have flattened the learning curve considerably for me.

+1

I think several people have mentioned it, and there have been
different possible actions, but nothing concrete AFAIK.

-- 
Felipe Contreras
