From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Lack of netiquette, was Re: [PATCH v4 00/13] New remote-hg helper
Date: Mon, 5 Nov 2012 17:15:06 +0100
Message-ID: <CAMP44s2CWb8FqDGG4-9X2soaQ+sBLkRRtrj0EkH1YSV8AUu9bg@mail.gmail.com>
References: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
	<5090EFCA.7070606@drmicha.warpmail.net>
	<20121031102712.GB30879@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210311900450.7256@s15462909.onlinehome-server.info>
	<CAMP44s2y-co4TELg28==axRmbF7xq3Qp7U8wjg6XtGAUMgf40w@mail.gmail.com>
	<20121031185903.GA1480@elie.Belkin>
	<CAMP44s2-UoT03OeTmM9=nh9wCUt84exPNuHyuThp=WQkxvCNLQ@mail.gmail.com>
	<alpine.DEB.1.00.1210312126080.7256@s15462909.onlinehome-server.info>
	<bec4d263-b458-4636-9fa6-1c1202416810@email.android.com>
	<CAMP44s2G2MGuPH-UXfoKNOpx0cuSE87Uz=6B-7H1MzJHf6VMjA@mail.gmail.com>
	<50927D29.3020703@lsrfire.ath.cx>
	<5093949D.4070509@op5.se>
	<5093A873.9090701@drmicha.warpmail.net>
	<CAMP44s0yk3k1awYbJCcReBDEAjMyfHtKH70S7v2ZOJ1u5OcBAw@mail.gmail.com>
	<5097860E.5040607@drmicha.warpmail.net>
	<CAMP44s3i1M9YtQb-EG+LS8DbwX10q2xE-LdxZCy3Xa_x3tQ9kA@mail.gmail.com>
	<5097E290.4030700@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Ericsson <ae@op5.se>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Nov 05 17:15:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVPKf-0002Dd-B4
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 17:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399Ab2KEQPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 11:15:09 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:37611 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab2KEQPH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 11:15:07 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5914858oag.19
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 08:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ra5sjF1zi9WO41XReEUdPnMOefLuDRmUSo00QbPm7os=;
        b=QSsy/grFXY5AJmB3Vak61a09rjIe5TFgjVy3VcBXGmX+QXv7rc5Kz6uvsHZFe4ZCdC
         h+RF6ecxuDlg0A7KGyxtf2N/oeqvOLRv8ve1C7AXOmezkyno+9WtTEFnWqQDyXuI4NdX
         zez1TQFKruhafrzNs5nazr4xS97iFeviEM8SqaU6W25O4jPKlzh3vTOShWJCwwwzgvMK
         3FUsQgFTYUDq3UIzP6325OTCo6QPiFt0Ff9FEbXkGYdURob7DZkRyahVsr6dB1phY1V4
         +FYAC0aAyw+Ug+x/l9e19a4zvBXjB/3oWMsfQv72O6F9f3DjLyI0/+KzC28z0SSc+3PZ
         CjnA==
Received: by 10.60.32.5 with SMTP id e5mr8191832oei.46.1352132106819; Mon, 05
 Nov 2012 08:15:06 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 5 Nov 2012 08:15:06 -0800 (PST)
In-Reply-To: <5097E290.4030700@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209074>

On Mon, Nov 5, 2012 at 5:00 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> [trimmed down heavily by mjg]
> Felipe Contreras venit, vidit, dixit 05.11.2012 16:22:
>> On Mon, Nov 5, 2012 at 10:25 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Felipe Contreras venit, vidit, dixit 02.11.2012 17:09:
>>>> On Fri, Nov 2, 2012 at 12:03 PM, Michael J Gruber
>>>> <git@drmicha.warpmail.net> wrote:
>
>> There is no lack of openness from my part. I hear all technical
>> arguments, and I reply on a technical basis. The problem seems to be
>> is that you expect the code submitted to be criticized, but not the
>> criticism it receives. IOW; the submitter has to put up with anything
>> anybody says about his/her code and ideas, but the *reviewer* is
>> untouchable; the submitter cannot ever criticize the reviewer. I can
>
> Feel free to criticize the criticism, just don't offend the criticizer
> (be it the reviewer or the submitter).

As I've said before; I've yet to see where exactly I have done so.

>>> And no, using the same or similar language does not make us the same at
>>> all. Using the same language is the natural prerequisite for successful
>>> communication.
>>
>> Nobody said otherwise.
>
> Well, you did in the post I responded to:
>
>>>> The dangers of "everyone" following the same style of communication,
>>>> and making "everyone" feel comfortable, is that "everyone" ends up
>>>> being the same kind of people

Style of communication != language.

You can use the same language and have vastly different styles of communication.

Imagine a society where everyone has the same style of communication.
Where your free speech ends the moment you diverge from this style.
Well, historically we know these societies have not worked, because
there's people with different styles of communication, and quite often
it's these styles of communication that are needed for certain
messages important to society to be heard.

Sure, it doesn't make you all the same, but it certainly makes it a
narrow spectrum.

> In any case, I feel I've showed enough efforts and there's no point in
> dragging this on.

How convenient. When I ask you specifically for examples where I have
offended anybody, or been harsh, you feel you have "showed enough
efforts"?

Claims require evidence.

Cheers.

-- 
Felipe Contreras
