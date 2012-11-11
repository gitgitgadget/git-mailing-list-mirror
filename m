From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Reviews on mailing-list
Date: Sun, 11 Nov 2012 13:24:14 +0100
Message-ID: <CAMP44s2GF03sKDA141d_5zY0tTDpBKqyb1hqoBmBJBbod-FL7w@mail.gmail.com>
References: <CA+ZXwZOnZZyk_KWmLLLNChWb1R_Av1s5jM4PsLFWKaG8BB+uXQ@mail.gmail.com>
	<CAMP44s2AvaAs-dn_eoSFWoLHBQk5QrrV=zYTOpRi2nEywoua4w@mail.gmail.com>
	<CA+ZXwZO8tpGi7_njbFx6w2ZAWoySVb2Bcc+DSupLenKrNAGV_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <sop@google.com>
To: =?UTF-8?Q?Deniz_T=C3=BCrkoglu?= <deniz@spotify.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 13:24:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXWaT-00044R-T9
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 13:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723Ab2KKMYQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2012 07:24:16 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44023 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538Ab2KKMYP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2012 07:24:15 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5434428oag.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 04:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=SITyjstfLEr2zpowi/SeBDtB2nyw4wF27CoHViRcnhI=;
        b=M8pdh3hkxz8U70vElCTgPLvpLG+8Opci96w21jZx6H0UEOSFXKr/6LuMUn7qnTJHQg
         fBQbU/AnBgUj3Mv3hqFW/+/bqrvU42Dyr1cm2FXoXFiFuMUBYqKh0xaZcYPWK0peWsGs
         aO19ZZ/RDyLV/PWwSYHI2JPC82lIE6FQwjTObTOPfsPU4HYEN6OfYoHgCVuwjMjU30rE
         avGW1zy1TH5mkiDx8AuUHTu+5efb+32VLUl1zbkSMlyZXe/MgUL6v3DGuGwEqvpeau67
         x7b4lOrqwX6FyFpwpke+y4zDpbiVyerLyT7ogDgQIuKpcldbhQhqGbwqQibZtwVk4Mri
         qFoQ==
Received: by 10.60.31.241 with SMTP id d17mr12115662oei.107.1352636654602;
 Sun, 11 Nov 2012 04:24:14 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 11 Nov 2012 04:24:14 -0800 (PST)
In-Reply-To: <CA+ZXwZO8tpGi7_njbFx6w2ZAWoySVb2Bcc+DSupLenKrNAGV_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209346>

On Sun, Nov 11, 2012 at 2:28 AM, Deniz T=C3=BCrkoglu <deniz@spotify.com=
> wrote:
> On Sat, Nov 10, 2012 at 3:40 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Sun, Nov 11, 2012 at 12:19 AM, Deniz T=C3=BCrkoglu <deniz@spotify=
=2Ecom> wrote:
>>
>>> This is my first mail to the git mailing list. I have been followin=
g
>>> the list for some time now and I would like to suggest moving the
>>> reviews out of the mailing list, for example to a gerrit instance, =
I
>>> believe it would improve the commits and the mailing list. I have a
>>> filter on 'PATCH', but I feel I miss some of the discussion, and
>>> things that I would be interested in.
>>>
>>> I have spoken to Shawn Pearce (gerrit project lead, google) and he
>>> said he is OK with hosting the gerrit instance.
>>>
>>> I would like to hear your thoughts on this.
>>
>> Personally I think reviews on the mailing list is far superior than
>> any other review methods. I've even blogged about it and all the
>> reasons[1]. Gerrit is better than bugzilla, but it still requires a
>> web browser, and logging in.
>
> I disagree that the current approach is optimal. Bugzilla is a
> bug-tracker and is not meant to be used for reviews. I believe in
> using the right tool for the right job. An e-mail should be concise
> and to the point, in this case only contain the discussion. This will
> help it to reach a wider audience and be more useful when people
> stumble upon it through a google search.

I don't understand what you are saying. If you google 'git reviews on
mailing lit', you will find results like this:

http://article.gmane.org/gmane.comp.version-control.git/209313

You don't get any patches because you didn't search for patches, and
either way Google would not filter out the results from gerrit either.
=46or example: googing 'cyanogenmod "Remove tabs from GNexusParts" will
throw:

http://review.cyanogenmod.org/

--=20
=46elipe Contreras
