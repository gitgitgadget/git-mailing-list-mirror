From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] user-manual: Simplify the user configuration.
Date: Thu, 22 Jan 2009 18:57:23 +0200
Message-ID: <94a0d4530901220857q1027c05bs137dcc0244a1cc5a@mail.gmail.com>
References: <1232561365-5919-1-git-send-email-felipe.contreras@gmail.com>
	 <7v8wp4e5wn.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530901211319t8126611wc1437848631fe988@mail.gmail.com>
	 <831vuvfh7t.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Hannu Koivisto <azure@iki.fi>
X-From: git-owner@vger.kernel.org Thu Jan 22 17:59:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ2tc-0002c2-7a
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 17:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203AbZAVQ51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 11:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754008AbZAVQ50
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 11:57:26 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:24332 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951AbZAVQ5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 11:57:25 -0500
Received: by ey-out-2122.google.com with SMTP id 22so841452eye.37
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 08:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ty9B1clvyJonAi2GIvj5Bxe2gCcBH5EQH89EetgWWSM=;
        b=Mr86yeQrHG86d6ySuaEEBm6DOp0icbOGWM4/89+4tDknYJ4mG5wx2/XPNXP/OovcDI
         wnw9+ySxdLz+rXaLhdAMJy6JS+gbIumanJcRurEsgtalnYAQrgN1RBFtYtfC5GUn2lOA
         ceHvHl8lajngu/n/W2KFoM8icx280YeCEsL3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pNfZ9mwOhUIr+1pKVqxkJ7h/+YFdO04Ngv3DajrYypZdL4OQWFJr8kAAm8STPeXAJN
         hNE+tcMq1JM5U6a9oVyDwPzFN2g+xYvKXX+N4NcgMDiIJruUJ36cFJBcSVDJVfzmahxr
         ODkQPt2ame+e3ti65hmWfmP7bnPaGTiG9na+8=
Received: by 10.86.68.2 with SMTP id q2mr230794fga.68.1232643443790; Thu, 22 
	Jan 2009 08:57:23 -0800 (PST)
In-Reply-To: <831vuvfh7t.fsf@kalahari.s2.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106771>

On Thu, Jan 22, 2009 at 6:17 PM, Hannu Koivisto <azure@iki.fi> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> This brings back my previous question: where is the home directory in
>> a Windows system?
>
> It's where %HOMEDRIVE%%HOMEPATH% points to.

I thought it was something like that. Do we want something like that
in the manual, or should we assume Windows users know that?

-- 
Felipe Contreras
