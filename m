From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: repository of handy git aliases?
Date: Mon, 8 Aug 2011 20:45:10 +1000
Message-ID: <CAH3Anrqx9moqpwLu8qAvam7o8RPiCo4TkojtqnDvjHpftb+mEA@mail.gmail.com>
References: <CAH3AnrpSeWytri-bHEi_9qkAKG1fjL0pVuYFOrrmZumJ6dv_wg@mail.gmail.com>
	<CANQwDwfwvaYQt+ck8ky0obyeAa--Wwtdme3UC4vNMFkSiBMq9g@mail.gmail.com>
	<CAH3AnrqEfu1jeCo55bJxLDK8845PsLoZtoT0iWkMUtt1+K9X-w@mail.gmail.com>
	<CAH3AnrrNPBNNNr7Lm2-vnqOisxWorF4FS32H+LBaybWF3KdnGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 12:45:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqNKe-0006Am-1b
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 12:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853Ab1HHKpL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 06:45:11 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51228 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab1HHKpK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 06:45:10 -0400
Received: by vxi9 with SMTP id 9so2341386vxi.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 03:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=tlq7TcQIYtGcdH53cZVef4kLGKWey01pgASRJxU11KY=;
        b=U4Zy5otvnupRx9ooAHCJ3Sld7r4lV4880zUwj1RMnAi2Z/8nGND7BhPLnP9mvwzz3p
         nL+cehpjFHeqKyCTjck/qheuH6R0hicImFRK58fRFyXIQFcdOESB3I+/+odbJAcTu6hL
         7cSUniNrWOlg376zgE/6NSGiL7DDX56PJw/wM=
Received: by 10.52.95.141 with SMTP id dk13mr5053374vdb.265.1312800310128;
 Mon, 08 Aug 2011 03:45:10 -0700 (PDT)
Received: by 10.52.183.134 with HTTP; Mon, 8 Aug 2011 03:45:10 -0700 (PDT)
In-Reply-To: <CAH3AnrrNPBNNNr7Lm2-vnqOisxWorF4FS32H+LBaybWF3KdnGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178953>

On Mon, Aug 8, 2011 at 8:43 PM, Jon Seymour <jon.seymour@gmail.com> wro=
te:
> On Mon, Aug 8, 2011 at 8:22 PM, Jon Seymour <jon.seymour@gmail.com> w=
rote:
>> On Mon, Aug 8, 2011 at 7:45 PM, Jakub Nar=C4=99bski <jnareb@gmail.co=
m> wrote:
>>> On 8/8/11, Jon Seymour <jon.seymour@gmail.com> wrote:
>
> I've also added this...
>
> Listing the tips of branches in pu that are not in master
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>

master -> next
