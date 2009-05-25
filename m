From: Michael Wookey <michaelwookey@gmail.com>
Subject: Re: Araxis in mergetool, was Re: What's cooking in git.git (May 2009, 
	#03; Mon, 25)
Date: Mon, 25 May 2009 20:05:24 +1000
Message-ID: <d2e97e800905250305l3f50d655y8a53300e4131ef16@mail.gmail.com>
References: <7vd49xy42b.fsf@alter.siamese.dyndns.org>
	 <alpine.DEB.1.00.0905251050050.4288@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 25 12:05:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8X3l-0005Af-2b
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 12:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbZEYKFZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 06:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbZEYKFY
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 06:05:24 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:9431 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbZEYKFX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 06:05:23 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1807233ywb.1
        for <git@vger.kernel.org>; Mon, 25 May 2009 03:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S0pvV2S2ZXZ4OyJZEOWATl2wzCtN8E5h8g3hnP92lrY=;
        b=A0d3jxW1R3gCVngH8A9LjUjT62pF+/M5jjD4MGui+U0ebunQ+eCvUotBTaN+mlJhrK
         SJA38Q0oqTy0nVL5V7bl4Dyf/jOj3B0zezjT0u+mb/xH3SsVZRky4aBkU0lSb9X+jeDY
         ZX03YGcucsLFmv4PcvjmakMQJMDxfn6+JGbpk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JQwlFThQPgvNCeMj+PBRrdiaIUr7W5pFKCh0eKp2ORGl7SYvv/KOj03Wk1+LbDFMOF
         qXNeUKAKZMUDDEwoDENUKWkkpGzXs8pEuyYd8cawnvBEWIfjmzmyJDwoZeul/y4Bfe1D
         A/rY+BWzuul7TLV0dAmD7BeiVcD9gr8+HqFbg=
Received: by 10.100.108.2 with SMTP id g2mr12311718anc.35.1243245924180; Mon, 
	25 May 2009 03:05:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0905251050050.4288@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119913>

2009/5/25 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Mon, 25 May 2009, Junio C Hamano wrote:
>
>> * da/araxis-mergetool (Sun May 24 00:24:41 2009 +0000) 1 commit
>> =C2=A0+ mergetool--lib: add support for araxis merge
>>
>> I admit that I feel certain distaste in supporting a closed tool, bu=
t we
>> already make things bearable for people on Windows; Araxis is no wor=
se,
>> right?
>
> Well, I think it is the first closed-source tool that we support, and=
 I
> would feel less unhappy if somebody reported back that she tested it =
and
> it works fine.

The mergetool support appears to work well using Araxis Merge on Mac OS=
X.
