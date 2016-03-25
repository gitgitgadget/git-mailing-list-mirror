From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [GSoC] Proposal
Date: Fri, 25 Mar 2016 10:30:54 +0530
Message-ID: <CAFZEwPOm0SvvsH_mzp+G6Me6zKU2GVk6AxMJ7iJOYuEJ7iJV2A@mail.gmail.com>
References: <CAKqreuwbGC1=42V2ZnTj53z76sgGcqfzjjrD7SP2AeuHJo9etQ@mail.gmail.com>
	<CAKqreuwFbObbMf_Lc6Lc01zrdGZf2qCTwgeD+db_CwebS_iDrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 06:06:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajJwv-0000tB-N6
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 06:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbcCYFA4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2016 01:00:56 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:34277 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbcCYFAz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2016 01:00:55 -0400
Received: by mail-yw0-f170.google.com with SMTP id h129so85706532ywb.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 22:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=Am/O/WrG+tJlycpw8V448KTfv2338eDnetdQa1Kz+7s=;
        b=U8jT0uS+/oGS35/zbxzepuhNdbuOQjg4fshgKoblzwPMcTFeFu+NTJXsE8uEbc4uc8
         msIg28l2ElHbx82893GEiKFBtUBxYtb6F8Lq02FzJmfKEf/X1V9Xa6iTqihapDH5mUBq
         YjCERuQaeSASCe2gDKVMqf89xyPAP09xi+vzqdeCOT3g2qSasIDv8OIltnytCid1B9cz
         5Rl9mgFzM6E/n+yybG++0ofF/B5AvYX/u6Ob5w4jvA53VUVbbKXf9ugkLxiZAL1KEFpm
         06JCZR5MJn6JzbHagmmlmUeJjaask4NRqC/NAbFFF759E79webkW6SZXTcyU/7bTMUpY
         i3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=Am/O/WrG+tJlycpw8V448KTfv2338eDnetdQa1Kz+7s=;
        b=Mamx3Ue/pWFuNXFUc4CW4MXXIQVBv5bS+8otsQAaFy61Nch1BWwDQSzyXvwY9v03n8
         NX2+49S3i1knsnaMLkFXiGtvP3qoK2Mc3bWk8OdR0sLITHmtJvdIU4n1ObVOD911UPkc
         +FTRweqXfg2JN7Lsee36aHyYN+N8txOwrXisDbA1ASNJz2zK58nXEYD5LYM+YKyh5vEh
         mAMlntpOciK1xu/BZ04kX1nbtIRSu4zDYeeNNXcrdO946Bur8SzLZMUvbEd7hBdA4KdT
         gG5F1NTyBjxY3LQyZPstQvnqu2dHr+UwMcaDM1WJhbCCR5kLXCfrD5uuPcG1oxF34/1Z
         aLkQ==
X-Gm-Message-State: AD7BkJJqKYC73JW6usWdZXY043fxHt1nx1MZeniEm0FGh4edncx3sHnIcE9r/Sm+uy2zn5y8fwnEOim+NeOFNA==
X-Received: by 10.37.100.196 with SMTP id y187mr6741989ybb.80.1458882054207;
 Thu, 24 Mar 2016 22:00:54 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Thu, 24 Mar 2016 22:00:54 -0700 (PDT)
In-Reply-To: <CAKqreuwFbObbMf_Lc6Lc01zrdGZf2qCTwgeD+db_CwebS_iDrg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289846>

Some developers are already working on that[1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/288306

On Fri, Mar 25, 2016 at 10:12 AM, =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun=
@gmail.com> wrote:
> There is an interesting idea as an idea for GSoC of 2008, is it still
> proposable?
>
> https://git.wiki.kernel.org/index.php/SoC2008Ideas#Restartable_Clone
>
> 2016-03-25 11:45 GMT+08:00 =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmai=
l.com>:
>> Hi,
>>
>> I'm proposing to take part in GSoC as a developer of git.
>>
>> Here is my [Draft](https://docs.google.com/document/d/1zqOVb_cnYcaix=
48ep1KNPeLpRHvNKA26kNXc78yjhMg/edit?usp=3Dsharing).
>>
>> I'm planning to refactor some part of git. Following is what I'm int=
erested in:
>>
>> - port parts of =E2=80=9Cgit rebase=E2=80=9D to a C helper
>> - =E2=80=9Cgit status=E2=80=9D during non-interactive rebase
>> - etc interesting during the development
>>
>> If time allow, I'd like to also improve git-bisect, for example:
>>
>> - convert =E2=80=9Cgit-bisect.sh=E2=80=9D to a builtin
>> - etc
>>
>> Sorry for toooo late. I was so busy these days. sorry again.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
