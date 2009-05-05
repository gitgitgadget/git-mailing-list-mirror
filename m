From: Anner van Hardenbroek <dwlnetnl@users.sourceforge.net>
Subject: Re: Question about rewrite commits
Date: Tue, 5 May 2009 15:27:19 +0200
Message-ID: <15aa6cf30905050627i5c8f4a8ftb33444f0a292ac6f@mail.gmail.com>
References: <15aa6cf30905050445k21f8317bt7be65857604cc101@mail.gmail.com>
	 <4A003677.3040802@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Tue May 05 15:36:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1Kp8-0007Ff-UO
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 15:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878AbZEENfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 09:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752912AbZEENfg
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 09:35:36 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:16267 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbZEENff (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 09:35:35 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2632761ywb.1
        for <git@vger.kernel.org>; Tue, 05 May 2009 06:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=m8X9R9LW7TDI1ijp7hMGybrPKDPXmnDf//m9HlU4x/Y=;
        b=WSW/UeL+VWI4QpDs8ycVl23R03HC3GqRNAthsWL7AIgnxD800mm0vwvTHoAEwkvuRD
         Mbol/X4EsNkl1Jw0kVMFyGeHcKtJKPWbf0Ndj9FD6yRN7TuM7ODad9tSol1PIvU0sDTL
         y1UFRYSvXGTgpI/unQfnSJlnoPGiK8K3hQ70g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ReC/ado+kQGOumF1NhUXb/e6ydDWqb+8MY/tmyCNUio4WRCuuomaahFCdfmeeA+4Qx
         hcl9JuRsFQNHQH9jo0gtRx2yN363/oXZoKfNFhpgt8I5W1UvRSvUyIEWWqfL70rcPs9z
         VMrswdwoeG7Qr93olgeBEfLUWC1VCrbj5msrI=
Received: by 10.151.137.5 with SMTP id p5mr193656ybn.223.1241530039528; Tue, 
	05 May 2009 06:27:19 -0700 (PDT)
In-Reply-To: <4A003677.3040802@pelagic.nl>
X-Google-Sender-Auth: 502be79eb23b3c5f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118297>

Yeah, okay but I'd like it visually.

On Tue, May 5, 2009 at 2:52 PM, Ferry Huberts (Pelagic)
<ferry.huberts@pelagic.nl> wrote:
>
> Anner van Hardenbroek wrote:
> > Hi!
> >
> > I've a question about rewriting commits. I'd like to change the
> > branches so that "Introduced BTRmxSoapArgument, second fase + code
> > cleanup." is right below (a straight vertical line) "No HTML errors
> > because we have nice ones!".
>
> it already is :-)
>
> or did you mean that you want to get rid of the merge? that's an
> entirely different question



--
Anner van Hardenbroek,
dwlnetnl@users.sourceforge.net
