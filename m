From: David <davvid@gmail.com>
Subject: Re: [PATCH ugit] Allow user to choose history browser tool
Date: Thu, 3 Jan 2008 04:35:01 -0800
Message-ID: <402731c90801030435h1d726e81sf24ad3eca5bd029f@mail.gmail.com>
References: <e5bfff550801030408w1512e458x136f6be0371c13c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 13:35:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAPIK-0000fu-Ts
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 13:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbYACMfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 07:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbYACMfE
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 07:35:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:33347 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbYACMfD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 07:35:03 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2644134ugc.16
        for <git@vger.kernel.org>; Thu, 03 Jan 2008 04:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=i4if7E6nrRXIttdLE6cvIAqm0ss7XpAO5pxasV2NfNo=;
        b=c7lS1C0MX5GQMsnDIbN8xD9Dsy8vyvOMfc2E1XYC/1f9UorazKR3od9nMO7qQqRw2MLwmXdS+ufKjc/fl92w+DSxt+busNvrtdOSoPFiuZBZa+fmHYmiht7TWLF0UDqOhkUgkoceoPjjppIyNwfTtAc10LN+XzjywWuT+dN4GUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z8rpyyeSGU6hLTy8GaBSG2mTJB/AHZSA0xwXdVulXGnPQ35OzxUc6GjFHXrrbJnk4WmD7E95sWIPtakGpiXF00kzxJr0W6k1gjkIUIE3JhpxosR/4kbD08t6dKSLTFwEhhQ6rwoaxZ03cgZshsjXDRc0NxKfgAT8FZy8SmXAu/w=
Received: by 10.66.254.19 with SMTP id b19mr15549683ugi.7.1199363701525;
        Thu, 03 Jan 2008 04:35:01 -0800 (PST)
Received: by 10.67.118.1 with HTTP; Thu, 3 Jan 2008 04:35:01 -0800 (PST)
In-Reply-To: <e5bfff550801030408w1512e458x136f6be0371c13c2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69525>

On Jan 3, 2008 4:08 AM, Marco Costalba <mcostalba@gmail.com> wrote:
>  Instead of hard linking gitk let the user set
>  the preferred history visualization tool in settings dialog.
>
> Signed-off by:  Marco Costalba <mcostalba@gmail.com>
> ---
>

Very nice, thank you!
I've applied this and fixed it so that the setting shows up on restart.
-David
