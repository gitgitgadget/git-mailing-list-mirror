From: Gareth Collins <gareth.o.collins@gmail.com>
Subject: Re: git subtree push-all and pull-all
Date: Mon, 8 Jul 2013 11:20:57 -0400
Message-ID: <CALemSr4Q_En+9eAbu2oRO-=EYt78sCB4nQjSO67W_m=nxu6KiQ@mail.gmail.com>
References: <CALemSr4Z+p7v_wQn7EOFTVHjtMYgxqGSBZf3zU5pn-eW_SEG5A@mail.gmail.com>
	<20130707125430.GA23197@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pcampbell@kemitix.net, rink@initfour.nl
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 17:21:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwDFP-0004jA-5g
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 17:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260Ab3GHPU7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jul 2013 11:20:59 -0400
Received: from mail-ea0-f172.google.com ([209.85.215.172]:49979 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab3GHPU7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jul 2013 11:20:59 -0400
Received: by mail-ea0-f172.google.com with SMTP id q10so3010433eaj.17
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=E3PJRJFNp6AbsOXa3ZvnoQgWVpG6HFk+HCBXjj0LDg8=;
        b=sRoKUH/4/YawiU/PJokIL2d25Afl3bSPngKduc7VHgD9PPFzZ58HhE81MqU9jzO5hS
         sQRL+GIePgN66jPgqS3amWWGuWqrmTB4qwAq3oTUvc7M1KlPX0OsDZ0384ccXOTZAMes
         6GN3N0iWuUbrzOTuQpTh8VWAYuNzhv2H5unmjnxNgXtQV6lWyWNkpKcoT5MixuEzwurc
         mddV4aq9g8gyWTA4nzzOfzM9ykPLBYvn0qUEcaY0SVy2jgGwaQJthvsXl6g3nuFvNgLQ
         i0PClqwKDnQ+eWTjkrMj2ew9BaU1y5uvHfdmXM4hZ+z6BK0vK/VdVBKWFxok9/zTYtAp
         +iSw==
X-Received: by 10.15.33.132 with SMTP id c4mr25993476eev.12.1373296857711;
 Mon, 08 Jul 2013 08:20:57 -0700 (PDT)
Received: by 10.223.73.196 with HTTP; Mon, 8 Jul 2013 08:20:57 -0700 (PDT)
In-Reply-To: <20130707125430.GA23197@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229865>

Hello Fredrik,

Thanks for the suggestion! Adding in Paul Campbell and Herman Van Rink
who worked on this before.

thanks again,
Gareth

On Sun, Jul 7, 2013 at 8:54 AM, Fredrik Gustafsson <iveqy@iveqy.com> wr=
ote:
> On Wed, Jul 03, 2013 at 03:56:36PM -0400, Gareth Collins wrote:
>> Hello,
>>
>> I see over the last year (on the web and in this mailing list) there
>> was some activity to extend subtree with a .gittrees file and
>> push-all/pull-all commands.
>>
>> Perhaps I missed it, but looking through the latest git code on the
>> github mirror I can't find any reference to the .gittrees file or
>> these commands.
>>
>> Does anyone know the status of this feature? Was it decided that thi=
s
>> was a bad idea and the feature has been rejected? Or is this a featu=
re
>> still "cooking"...which will likely make it into git mainline at som=
e
>> point?
>>
>> I ask because I would like to use something like this to be able to
>> keep a combined repository and separate project repositories in sync=
=2E
>> Of course, if it was decided that this feature is fundamentally a ba=
d
>> idea then I will do something different.
>>
>> Any pointers would be a big help.
>>
>> thanks in advance,
>> Gareth Collins
>
> Still no answer to this? I suggest that you CC the persons discussing
> this the last time.
>
> --
> Med v=E4nliga h=E4lsningar
> Fredrik Gustafsson
>
> tel: 0733-608274
> e-post: iveqy@iveqy.com
