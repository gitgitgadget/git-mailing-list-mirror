From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 0/4] Good bye fnmatch
Date: Sat, 15 Feb 2014 09:49:57 +0100
Message-ID: <871tz43glm.fsf@fencepost.gnu.org>
References: <1392429709-9237-1-git-send-email-pclouds@gmail.com>
	<8761og3htv.fsf@fencepost.gnu.org>
	<CACsJy8C+3AED3p0sWb91gq6tY4zAH+k0SdMv0RkpeqJPzL+naw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 15 09:50:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEawl-0006Bz-FJ
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 09:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbaBOIt7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Feb 2014 03:49:59 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:49320 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbaBOIt7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Feb 2014 03:49:59 -0500
Received: from localhost ([127.0.0.1]:48362 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WEawg-0008PM-Da; Sat, 15 Feb 2014 03:49:58 -0500
Received: by lola (Postfix, from userid 1000)
	id E2533E40F5; Sat, 15 Feb 2014 09:49:57 +0100 (CET)
In-Reply-To: <CACsJy8C+3AED3p0sWb91gq6tY4zAH+k0SdMv0RkpeqJPzL+naw@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 15 Feb 2014 15:29:39 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242180>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Feb 15, 2014 at 3:23 PM, David Kastrup <dak@gnu.org> wrote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes=
:
>>
>>> Long story short, we wanted globbing wildcard "**" so I ripped
>>> wildmatch library from rsync to do it.
>>
>> Since version 3.0.0, rsync is GPLv3
>> <URL:https://rsync.samba.org/GPL.html>.  So be sure to take an older
>> version.
>
> Yes. See 5230f60 (Import wildmatch from rsync - 2012-10-15), the code
> was taken from the last GPL-2 commit.

Thanks.

--=20
David Kastrup
