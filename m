From: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Subject: Re: [L10N] Kick off for Git 1.8.5 l10n round 1
Date: Sat, 02 Nov 2013 09:41:40 +0700
Message-ID: <52746664.1050806@gmail.com>
References: <CANYiYbFoU3oSvmXvHfZj3js==4CxsU-0UZs_WU+VvrCNVGYRKg@mail.gmail.com>	<527457A0.9010600@gmail.com> <CANYiYbGmiBK23=A=MbkfSWwe8X8q3vYSvYPZXhKTLUsbLbMDsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	git-malling-list <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 02 03:42:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcRAF-00064G-Rq
	for gcvg-git-2@plane.gmane.org; Sat, 02 Nov 2013 03:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545Ab3KBCly convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Nov 2013 22:41:54 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:57496 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479Ab3KBClx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 22:41:53 -0400
Received: by mail-pd0-f169.google.com with SMTP id q10so4661185pdj.28
        for <git@vger.kernel.org>; Fri, 01 Nov 2013 19:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=cNLhFkQa94RvXlUCLu59IvmV70YxmuCTFAGTfuctt0A=;
        b=W1rypC3FhWL8Prlvn8kMkXn9l7Rzu79cJI/BDfTpSKLloLmUfs6mvg4I5DqrGaKl+B
         8U+hV3Ag5g5a1saTE8scPU2vUyDIa8iQliuJuxqkIAwChTjPu3wDhbOpAKpvxqDe1XcG
         jhf5cOeYyPTlC7H2gaq/lrEWP6M9vWD4fRX02vl8/dbPj99kCrMIyJa+rb85FhUk/3G7
         UcPZHIfSn9AcO6Gu0O8fHqP+f2EZX/ma/jbXFX3n639giuEM31+Z0hdAsVcE9VBjDckX
         PggBSpxvjagALgskE89mY2CYOslbaWezJVEem4anUtCXUE+LODcOMsRTyR+Ys/0jaCIp
         ePZQ==
X-Received: by 10.68.33.100 with SMTP id q4mr6079140pbi.119.1383360113266;
        Fri, 01 Nov 2013 19:41:53 -0700 (PDT)
Received: from [192.168.1.100] ([113.184.62.59])
        by mx.google.com with ESMTPSA id py4sm13830399pbb.33.2013.11.01.19.41.51
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 01 Nov 2013 19:41:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <CANYiYbGmiBK23=A=MbkfSWwe8X8q3vYSvYPZXhKTLUsbLbMDsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237235>

On 02/11/2013 09:23, Jiang Xin wrote:
> 2013/11/2 Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail.com>:
>> Strings in builtin/remote.c line 15 and 42 is similar, please change=
 to
>> same string in order to reduce gettext database (.mo file)
>> --
>>  Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n.
> Confirmed, there is a typo in builtin/remote.c line 15. Have you send
> patch to this list for this, Tr=E1=BA=A7n?
>
This is minor error, so let Junio C Hamano do it!

--=20
Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n.
