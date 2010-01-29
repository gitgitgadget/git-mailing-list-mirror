From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 23:00:33 +0100
Message-ID: <fabb9a1e1001291400te0d993dx314720c01c646b8c@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com> 
	<fabb9a1e1001291235h26681e65qe4851cae1c536b6d@mail.gmail.com> 
	<7veil8iqnj.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001291614550.1681@xanadu.home> 
	<fabb9a1e1001291321v708c7cb4sec8e944f336d04fd@mail.gmail.com> 
	<alpine.LFD.2.00.1001291628510.1681@xanadu.home> <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com> 
	<alpine.LFD.2.00.1001291641200.1681@xanadu.home> <7viqakh8ty.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nicolas Pitre <nico@fluxnic.net>, Git List <git@vger.kernel.org>,
	Ron1 <ron1@flownet.com>, Jacob Helwig <jacob.helwig@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 23:01:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Naytg-0002fl-2B
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 23:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570Ab0A2WAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 17:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367Ab0A2WAy
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 17:00:54 -0500
Received: from mail-pz0-f190.google.com ([209.85.222.190]:61922 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab0A2WAy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 17:00:54 -0500
Received: by pzk28 with SMTP id 28so1909880pzk.4
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 14:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=8Q78HQEr5DoGzm/BvEJ7+S0ixa1pBcUNlzIa3hCRwsE=;
        b=MP3p6fpBTOvkMxM/lZ3qYu9Ya2GWrq+iCId9GfE6YXezmyrtpvR+G6orZkgk9y15DQ
         fH09MKf18JnSZ2bXwkWroekJge4+qy6yRqp6e5UBzudetVdyFw6XS/yvlIgeSq499CBn
         ZfsWaNRwB8ayUfdcZ18D3RXf+oDIfCSyJvy9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=uucmy+IOY+4tdnsHfzL93wKsILFLzz/WPQrBHSQImiQe3fTjqSmpgrcGunKotOQngB
         fIxpUiRcvRuwDO/q3BqjJrSi3pDpCweJDZfVFbIjMOylZW0mKBGjIH+THdFw5PDZWDMQ
         7oKVZ6T+GAOGaxYdPXBzwm3EDMwfCMEGpz5K0=
Received: by 10.143.153.30 with SMTP id f30mr926283wfo.281.1264802453873; Fri, 
	29 Jan 2010 14:00:53 -0800 (PST)
In-Reply-To: <7viqakh8ty.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138381>

Heya,

On Fri, Jan 29, 2010 at 22:58, Junio C Hamano <gitster@pobox.com> wrote:
> Sverre's explanation does not match reality.

Heh, that's the second time I messed up explaining this new feature,
maybe I should stop doing that... eh... my bad.

-- 
Cheers,

Sverre Rabbelier
