From: "Dan Chokola" <dan@chokola.com>
Subject: Re: Git cheat sheet
Date: Wed, 29 Aug 2007 09:47:42 -0400
Message-ID: <61e816970708290647r50f4d079k8e0984527bcdbe2e@mail.gmail.com>
References: <200708290348.02853.zack@kde.org>
	 <7vfy22squc.fsf@gitster.siamese.dyndns.org>
	 <200708290855.39505.zack@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Zack Rusin" <zack@kde.org>
X-From: git-owner@vger.kernel.org Wed Aug 29 15:47:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQNtc-0001uF-DD
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 15:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757859AbXH2Nro (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 09:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757766AbXH2Nro
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 09:47:44 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:35659 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756364AbXH2Nrn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 09:47:43 -0400
Received: by wa-out-1112.google.com with SMTP id v27so196025wah
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 06:47:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=axmaK+PkeDxx/+wm+EnlqbgUfoiUk4E92gY0EPUWrea0Op87YB0SBIt//dEFHad3AUCTDpa0D46lyKiyymWQq66mbDUZU3jlyVX27l8QLdVUOos7OyrnsXHFKwO23jut0ymirn3Dz2gfhhbmS0jx3vvDfK1ylNgOlzthMNLaFec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=D6jq+E/xw0AYf24JAWFT5EC4qiZCh8W0nRD3rEy5orCtLVlTcttjZiYc2XG/oalQV2cHtcRBzIjmT+N96OOhn+bzBWBqzF8H8go0lEjkt2BCmZvgy4h0xUsD7mtQUaPNGNI3qipzzOP+2C1DucZBG4cQ2LS1JnfnDEicKoDkKn4=
Received: by 10.114.77.1 with SMTP id z1mr514008waa.1188395262730;
        Wed, 29 Aug 2007 06:47:42 -0700 (PDT)
Received: by 10.114.208.19 with HTTP; Wed, 29 Aug 2007 06:47:42 -0700 (PDT)
In-Reply-To: <200708290855.39505.zack@kde.org>
Content-Disposition: inline
X-Google-Sender-Auth: a9b385363f091d06
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56948>

On 8/29/07, Zack Rusin <zack@kde.org> wrote:
> Thanks a lot for the comments.
>

One more. You might want to add git apply to the "Change" part of the
command sequence.

-- 
Dan Chokola
