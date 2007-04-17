From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: GIT vs Other: Need argument
Date: Tue, 17 Apr 2007 11:26:47 +0100
Message-ID: <200704171126.48793.andyparkins@gmail.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <vpqejmjjrdp.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 12:27:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdktl-0006q6-Tm
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 12:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbXDQK0z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 06:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753362AbXDQK0z
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 06:26:55 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:40843 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbXDQK0y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 06:26:54 -0400
Received: by mu-out-0910.google.com with SMTP id g7so2249100muf
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 03:26:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AC9Z4lgGA4ikrKC47srBr1IzuZkBTnE0AIMO9c3FTzIYAGbiVHoDIrdk2fGP9ZDx3Rn7niNm8cNBCYMh4WLn/Cv1LhlJzaYXHioFQCYJEWUa5H/VIcZ8AMJAfMGKZZMM8UcsKKOLahi80kEe8wXT5UonC2mASEiQ8AfzUM7a8go=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Opj4fcCDlIPP8EA5oXXkz0TIRvRbhwilpgJVyUAFKVQimXoAoveLJzEOdhMcO8DJPd6U8BEFVyr4b+4eakMOSnoswHH0x+COMwGy1RuGGm88Evd/5apSvBpUEHkEHw+53TfvB6ch7dvBurT8EQI6zJj2gXtYoem4tFhTI7nitSU=
Received: by 10.82.148.7 with SMTP id v7mr2437429bud.1176805612929;
        Tue, 17 Apr 2007 03:26:52 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id c22sm2361058ika.2007.04.17.03.26.49;
        Tue, 17 Apr 2007 03:26:50 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <vpqejmjjrdp.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44756>

On Tuesday 2007 April 17 10:13, Matthieu Moy wrote:

> * Atomic commits. CVS makes it hard to get back to a consistant state
>   in the past. What does it mean, for example to checkout revision 1.5
>   of a project in CVS (hint: nothing, it's meaningfull for a file
>   only).
>
> * Rename management.
>
> * Performance.
>
> * Perhaps your boss will be interested in the "data integrity" (i.e.
>   git fsck) problem too.

Don't forget
 * Can work offline

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
