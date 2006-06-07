From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Classify commands in stg --help output.
Date: Wed, 7 Jun 2006 21:56:26 +0100
Message-ID: <b0943d9e0606071356i5099b323qaa176d22b04a2ef@mail.gmail.com>
References: <20060528212519.3207.76228.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 22:57:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo557-0006qY-GT
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 22:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWFGU41 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 16:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWFGU41
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 16:56:27 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:14806 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932355AbWFGU41 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jun 2006 16:56:27 -0400
Received: by nz-out-0102.google.com with SMTP id l8so249317nzf
        for <git@vger.kernel.org>; Wed, 07 Jun 2006 13:56:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Inx9QAvIgbc3s+O6vobQhopd1hUA7gLEXl8MfGEDWnaiCTdlSWSCxkFI5/O0c14o3MEctjvb8rO8aXL2ExGpaSPeJycmbYRlPWIxBxHv+XBriEqSlmTbsEXOHcVoakMQSCHxLiyOP60TkL6gaWLK8QkZNZ9N8Ay4vML28xmgdT0=
Received: by 10.36.121.1 with SMTP id t1mr1257233nzc;
        Wed, 07 Jun 2006 13:56:26 -0700 (PDT)
Received: by 10.36.250.61 with HTTP; Wed, 7 Jun 2006 13:56:26 -0700 (PDT)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20060528212519.3207.76228.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21460>

On 28/05/06, Yann Dirson <ydirson@altern.org> wrote:
>
> Commands will be much easier to find out that way.
> Inspiration mostly comes from pg-help.

Applied, with a small difference - I moved 'pull' to the repository
commands (it looks better there since it is not directly related to
the stack).

Thanks.

-- 
Catalin
