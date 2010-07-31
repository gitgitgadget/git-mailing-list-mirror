From: Benson Margulies <bimargulies@gmail.com>
Subject: Re: On MacOS, 1.7.2, git svn clone seems to fail silently
Date: Fri, 30 Jul 2010 22:28:52 -0400
Message-ID: <AANLkTikwTqQpVO5SMUgqPr04=kAh570zT_RWdxjipid9@mail.gmail.com>
References: <AANLkTimxqC3oax=Q0EppAb-Q7AzHshRkV=H=6dJDNhqY@mail.gmail.com>
	<20100731013509.GG5817@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 04:29:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of1p3-0005Ci-DE
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 04:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430Ab0GaC24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 22:28:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48567 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062Ab0GaC2z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 22:28:55 -0400
Received: by wyb39 with SMTP id 39so1760735wyb.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 19:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=UOmT8GMXUrxwTeKFDtBbRpeu+ymyu1o+BH8fj5ZztIM=;
        b=pFnsRAcN9RO33cEqYDdOvHXEbpQ6KMu9yklrl3UmJpyt6ebjKgfymknxtTE/npXlyk
         CKnlSIwSrHB0wxdFNpMppntdJl2aG8cwBYnS5JWGq04LKGvKV8gIT1Rs1qpMnWjKm6kz
         oppYxeHspc8/uBeg47rT725p79QU/RfL4hLmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=BdN+OXpkEsSFBrJHm+eQstqzxClWVaRzzDuQBHsIQp0bWyBVVAFNTWlvVW+tKsm4zU
         tn/6TYR5iGNLplO4NSS5cgXNDHP6Pql969TwEIkOSwUg4s8+QuZ4pO7oG7VSQ5yRiYQp
         tbodUocHqCdcAmMlSj1ONrfdN/6hMeXRkEEqk=
Received: by 10.216.28.213 with SMTP id g63mr318310wea.71.1280543332896; Fri, 
	30 Jul 2010 19:28:52 -0700 (PDT)
Received: by 10.216.155.17 with HTTP; Fri, 30 Jul 2010 19:28:52 -0700 (PDT)
In-Reply-To: <20100731013509.GG5817@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152288>

$? -> 0

The numbers in tags-maxRev don't go up with each 'fetch'.
