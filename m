From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/4] completion: be nicer with zsh
Date: Thu, 2 Feb 2012 12:18:54 +0200
Message-ID: <CAMP44s058VWdjJW-pUH5V4WJ4B3r6Oq9STqGHVREuD5rtP1V8Q@mail.gmail.com>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
	<1328145320-14071-2-git-send-email-felipe.contreras@gmail.com>
	<20120202081622.GB3823@burratino>
	<CAMP44s3FxUmnpQevoV2ARJpWK9CJ16zXDmpJRDOLHNW6RdSc5Q@mail.gmail.com>
	<20120202091059.GE3823@burratino>
	<CAMP44s0nD4p9=fwpLwchmGJ123onLmRaSPmOL+cYpTFCJ-jwXw@mail.gmail.com>
	<20120202094624.GF3823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 11:19:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rstkr-0005AH-KQ
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 11:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755347Ab2BBKS5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 05:18:57 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46009 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755341Ab2BBKS4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 05:18:56 -0500
Received: by lagu2 with SMTP id u2so1185158lag.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 02:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5OC04CIujJix//1XzGZ818iVX3gzZxF3G7J7cGOk0DA=;
        b=pw2pij64ctGLvvmRd6YoY1en694UhWlWrcqLTCkJ8vDDPUrYpkKKHu4c1KlUIQEt1c
         KsjPvWYRsFYXa4/VDjh5B8PJd+Htp+NOym8Rz6z8nKllxcZaTuXOF1fiJxDilzB3wxOg
         Q2JgMuh3TBzSxsZT8VWuBg6kMHttmjnNTXkqI=
Received: by 10.112.25.106 with SMTP id b10mr558034lbg.102.1328177934774; Thu,
 02 Feb 2012 02:18:54 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Thu, 2 Feb 2012 02:18:54 -0800 (PST)
In-Reply-To: <20120202094624.GF3823@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189615>

On Thu, Feb 2, 2012 at 11:46 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>> On Thu, Feb 2, 2012 at 11:10 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>
>>> See [1] for details. =C2=A0If there's no obvious explanation, I'd s=
uggest
>>> contacting the postmaster.
>>
>> But there's nothing like the taboo words in the mail:
>> http://vger.kernel.org/majordomo-taboos.txt
>
> Why are you telling me? =C2=A0I am not the postmaster. =C2=A0I can't =
do anything
> to investigate it or fix it.

I'm not telling you, this is a conversation on a public mailing list.
Other people might know something about, or they might hit the same
issue in the future. It's good to state things on record.

And FTR, I had already contacted the postmaster, which has been not
exactly helpful in previous occasions, but lets see.

--=20
=46elipe Contreras
