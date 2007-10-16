From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] Git homepage: remove all the references to Cogito
Date: Tue, 16 Oct 2007 10:01:06 +0200
Message-ID: <4d8e3fd30710160101p3579a719q9d4133cf3edf040f@mail.gmail.com>
References: <20071015233800.6306e414@paolo-desktop>
	 <20071016021933.GH12156@machine.or.cz>
	 <vpqlka3sdka.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, git@vger.kernel.org
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Oct 16 10:01:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhhMf-0000rx-6G
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 10:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757906AbXJPIBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 04:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755142AbXJPIBJ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 04:01:09 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:60808 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123AbXJPIBI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 04:01:08 -0400
Received: by an-out-0708.google.com with SMTP id d31so188160and
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 01:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CfZOIj3/mQnFz9w5ziVqSiVV/tikn9MC/PeOwcDtI2w=;
        b=t69L28p3hAjFN8IQbo0y9nGRaVmDVvIwsPhpfzFeSSQyTYtsQaJaKfyd2u3XBRzlvgDOcsAfP05H0Yv8jJbeZ6i2fcHS6xa9E0Zczer1ST+HnZKMTJI9/yocx1waNyBgHMSnn8mqN8NtaOLt9SbawE9Idm1rIe2V4E/1JfBEY34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BxkW0TIaDjVzwIxMErXNzAqlbcexAvceloXmSbVArkrlDSO6XdKvtGz6Jgr3O/EHNOcmX0xDCNRx4Q2HPHBH90Ko/McsvtbQcHgKrbbF4eutfW/F8xbXo1Vxq/hZ3Vp+IsieEAxQLfCcIs2dXN+jFs5oCYGNF+xFQXJ7nXO5G2E=
Received: by 10.142.131.18 with SMTP id e18mr1824862wfd.1192521666305;
        Tue, 16 Oct 2007 01:01:06 -0700 (PDT)
Received: by 10.143.43.21 with HTTP; Tue, 16 Oct 2007 01:01:06 -0700 (PDT)
In-Reply-To: <vpqlka3sdka.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61110>

On 10/16/07, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Petr Baudis <pasky@suse.cz> writes:
>
> > I'm not sure this is good idea, Cogito is still quite frequently used
> > and it should be documented that it exists.
>
> I think reformulating the mention to cogito (use past sentence like
> "cogito was a popular ...") would be better. As a side-effect, it
> would also credit you for your work, which I think is fair :-).

Yes, I probably be too rude. Sorry abot that Pasky, I just feel like
the home page is a bit confusing with regards to Cogito. My
understanding is that it is no longer maintained and therefore we
probably should not encourage new user to use it.

Maybe changing:
Cogito
    Cogito is a popular version control system on top of Git. It aims
at seamless user interface and ease of use, providing generally
smoother user experience than the "raw" Git interface and indeed also
many other version control systems. However, it also lacks many
advanced capabilities of Git and is currently being slowly phased out.

into
Cogito
    Cogito was a popular version control system on top of Git. It aims
at seamless user interface and ease of use, providing generally
smoother user experience than the "raw" Git interface and indeed also
many other version control systems. However, it also lacks many
advanced capabilities of Git and is not actively maintained any
longer.

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
