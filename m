From: "Remi Vanicat" <vanicat@debian.org>
Subject: Re: [PATCH] Adding menu for Emacs git.el
Date: Tue, 11 Dec 2007 17:27:42 +0100
Message-ID: <6b8a91420712110827q320fbe00t100547f22504143@mail.gmail.com>
References: <87mysvfr7e.dlv@vanicat.homelinux.org>
	 <87fxylos4o.fsf@wine.dyndns.org>
	 <877ijwfh6z.dlv@vanicat.homelinux.org>
	 <7vhciphh4k.fsf@gitster.siamese.dyndns.org>
	 <878x41idvb.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Alexandre Julliard" <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 17:28:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J27xy-0002UO-9j
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 17:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbXLKQ1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 11:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbXLKQ1s
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 11:27:48 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:62660 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbXLKQ1r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 11:27:47 -0500
Received: by py-out-1112.google.com with SMTP id u77so338204pyb
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 08:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=98XRvRtWx6lOKuYp/WrWnNYT5yju/Lgs35gtc7ajxiM=;
        b=U+9gL84Slk2RWXaRhSE0BwhjHLkY89AlWIqHig8DHCw0cf2y8MhbbPQpGbh0XRQrBqGSiNtTkiv11rgK2YYY3yFWtNzc+P/IU+UhUexxQnNtmA+23r2ttFucPrqW8D1XOuus25aZOzje2XszchgrgvePT8OGmbRtn9KhuBDufdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ZV0wz9dXTZB5wNgPR1WjHkyOAP4xHY92PlTU6S9N7iK1G5fAQIejo/+EQqM0+O1neEjbXXxDYCbo0Mcnp9eR2E8T0bt580oYm1paW9W4XuzFklGb3WiSMUxDowVTvH/Vw4njar7d0JongkDv51ZZHjLUQ3em+Z3T28uaIFJmYKo=
Received: by 10.35.82.16 with SMTP id j16mr9128384pyl.1197390462669;
        Tue, 11 Dec 2007 08:27:42 -0800 (PST)
Received: by 10.35.47.8 with HTTP; Tue, 11 Dec 2007 08:27:42 -0800 (PST)
In-Reply-To: <878x41idvb.fsf@wine.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: f0ed59d0177b94d3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67882>

2007/12/11, Alexandre Julliard <julliard@winehq.org>:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Alex, what is the current status of this patch?
>
> Patch v3 looked good but the patch file was corrupted. Here's the latest
> version, I have moved things around a bit to use only one menu and to be
> more similar to pcl-cvs.
>

It look good
