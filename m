From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/3] user-manual: use 'fast-forward'
Date: Mon, 12 Oct 2009 13:05:04 +0300
Message-ID: <94a0d4530910120305o49ed7c74sf6a03097b1098a5f@mail.gmail.com>
References: <1255293973-17444-1-git-send-email-felipe.contreras@gmail.com>
	 <1255293973-17444-2-git-send-email-felipe.contreras@gmail.com>
	 <1255293973-17444-3-git-send-email-felipe.contreras@gmail.com>
	 <1255293973-17444-4-git-send-email-felipe.contreras@gmail.com>
	 <7veip9jj6z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 12:14:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxHvA-0002ZV-Do
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 12:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446AbZJLKGy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2009 06:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753695AbZJLKGy
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 06:06:54 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:35055 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549AbZJLKGx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2009 06:06:53 -0400
Received: by fg-out-1718.google.com with SMTP id 16so396604fgg.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 03:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Onz3RFqgX7qY6vYAn8qg/kFxpPBwLJdBr3aX+o3iN78=;
        b=ECsv3r83WdzflISjCkjfBPoBRmb73+AiIPYNaWmKWOHc9QpbZZsmiqA9W52S80qEOY
         WxNjseFYUPGLPEb4fFePUucmTsUwqUK2WH4eA9WdOXMLtGSz83EclLEqcEQRFG2Et2YJ
         9mxzNpK2Pb6n+ahodT8Osz6VSL1O8br8P8BxU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Un6bWYRpU11XjaumYl8K/SsamHKcAIetjP3i4/uHI97bPWWKN2N763t6qiOsjlKml6
         KogU/+FMB0yYNcBzWs/Amq4q6jTHn5sRgd8atelmBIWZS4053JIkB1rY4Crkit0enbUi
         ZjU4nONN1tqqf3MdmE3tDhf4ByRAUEjJppNCc=
Received: by 10.86.225.38 with SMTP id x38mr5083064fgg.59.1255341904930; Mon, 
	12 Oct 2009 03:05:04 -0700 (PDT)
In-Reply-To: <7veip9jj6z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129999>

On Mon, Oct 12, 2009 at 8:05 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> It's a compound word.
>
> Thanks.
>
> This removes 7 out of 37 "fast forward" in Documentation/ directory. =
=C2=A0Are
> we going to convert the remaining ones, too?

Sure. Once I finish pushing the patches I have for user-manual, which
is the one I'm interested right now.

--=20
=46elipe Contreras
