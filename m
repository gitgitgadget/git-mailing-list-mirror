From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] gitk: avoid Meta1-F5
Date: Thu, 14 Jun 2012 00:36:32 +0200
Message-ID: <CAMP44s0mgEUjA5E2hFcMewXU+mGbh512+o5wShBqm2cVns3KBA@mail.gmail.com>
References: <1333758578-9334-1-git-send-email-felipe.contreras@gmail.com>
	<20120425034544.GA9660@bloggs.ozlabs.ibm.com>
	<CAMP44s34CAKbSKd=xKT_zS7sDOQCH-=9gXswdhmYhjFCTYPA8g@mail.gmail.com>
	<4FD90DA8.9080603@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	"Daniel A. Steffen" <das@users.sourceforge.net>,
	Alexander Gavrilov <angavrilov@gmail.com>
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Jun 14 00:36:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SewB4-00026E-Ob
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 00:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093Ab2FMWgf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 18:36:35 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:48492 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648Ab2FMWge convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2012 18:36:34 -0400
Received: by wibhn6 with SMTP id hn6so1187114wib.1
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=VYlEbRRYlqtjFRAcnzk0MLX9DqhmKbH6CcycNdBM9uQ=;
        b=0BkdiSHcv9R25Ui521I6UrjeuwKK187JSdwNs2tIghsQ9fVNfr53KtxQoh5YBCXmrP
         Tn5FxCfuhLNKnBvZsgCqiHwD7mTXo+Lt5APRe6QVwn8q4wzp+oVZbVQRBdFNXHJTd815
         xrEHGB0s8fmtDqM8P8V6oVGDPC7gM9uxJyfqFqVX589Prn3blweE8xpnMcunO0Et6iUl
         GW5IOxQiRt7X2QgXwDGzO4FlT0Llnse8P3XTNFaSJtuYJCgu8YBhvJLT8ZYkVkE/F/dv
         XOp7hhsCrjbS0fFZR3g4F3iTmv2ZYo28QXp58rsK/JuZ5ApZGL13fDsKpuGxJlQ+3MVo
         hEbw==
Received: by 10.180.80.74 with SMTP id p10mr41636111wix.10.1339626992964; Wed,
 13 Jun 2012 15:36:32 -0700 (PDT)
Received: by 10.216.226.85 with HTTP; Wed, 13 Jun 2012 15:36:32 -0700 (PDT)
In-Reply-To: <4FD90DA8.9080603@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199954>

On Thu, Jun 14, 2012 at 12:01 AM, Zbigniew J=C4=99drzejewski-Szmek
<zbyszek@in.waw.pl> wrote:
> On 06/13/2012 05:00 PM, Felipe Contreras wrote:
>> On Wed, Apr 25, 2012 at 5:45 AM, Paul Mackerras <paulus@samba.org> w=
rote:
>>> On Sat, Apr 07, 2012 at 03:29:38AM +0300, Felipe Contreras wrote:
>>>> This is commonly mapped by window managers and what not. Use Shift=
-F5
>>>> instead.
>>>>
>>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>>
>>> Thanks, applied.
>>
>> Does this translate into some action? I still don't see this change =
in
>> Junio's tree.
> It's in git://ozlabs.org/~paulus/gitk, the place where gitk lives.

So what is this?
http://git.kernel.org/?p=3Dgit/git.git;a=3Dblob;f=3Dgitk-git/gitk

--=20
=46elipe Contreras
