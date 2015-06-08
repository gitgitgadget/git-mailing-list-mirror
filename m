From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: release address not working
Date: Mon, 8 Jun 2015 15:17:06 +0200
Message-ID: <CAEcj5uWCdf7_NNE2v8Ly2EE-1oEiN2bJs5ogBEDSZxYttOjyiw@mail.gmail.com>
References: <CA+e85DLH=K8n3xcZnfyF85Rwyqnc_5amrZE1P_++E+k+NN18xA@mail.gmail.com>
	<CA+e85DKhpyo2wsRY=LNzOyhemjj48ewS50+eQkfcPjoDD4KZyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: =?UTF-8?Q?Mustafa_Kerim_Y=C4=B1lmaz?= <mkysoft@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 15:17:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1wvR-0006Iv-Kz
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 15:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbbFHNRJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2015 09:17:09 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33875 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbbFHNRI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 09:17:08 -0400
Received: by lbcmx3 with SMTP id mx3so80487400lbc.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 06:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=lFS9nXkv07jqx87cXsU/6KgFgF0ew/gc+Mu5vN7R8so=;
        b=RIfAOKRcfCU1wusLDjuMjCleSwgHh37u05S9bSQGT5A0bAqLU/9cck1tlj3y3Gy7o8
         76m3H1EV0YYOcmwfDkzbexv41oVDpmCIKOJSLyWqDUJdK1Vojy6+QblMp4uvBXnflXer
         ceeTHjm5ULXFFbah59eCsYD5z5y8zCD6bNNM7g+sjuYjtDS3sfuFe+w5yoWe1BjzXDby
         tF7uvhhOifVMn2FpOdCcHNZAF50GtjFl+SemQdxwpTT5Qn2B4iAJ/lXvZeLU1l49Gbvy
         eG3K++JmgHs17IKgJbadqKYUTbCm7/nSUWlioR0BL9286ialUroTzhqlvxd+6VmO6nY/
         37vg==
X-Received: by 10.152.203.162 with SMTP id kr2mr16755286lac.68.1433769426347;
 Mon, 08 Jun 2015 06:17:06 -0700 (PDT)
Received: by 10.25.20.76 with HTTP; Mon, 8 Jun 2015 06:17:06 -0700 (PDT)
In-Reply-To: <CA+e85DKhpyo2wsRY=LNzOyhemjj48ewS50+eQkfcPjoDD4KZyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271029>

On Sun, Jun 7, 2015 at 12:13 PM, Mustafa Kerim Y=C4=B1lmaz <mkysoft@gma=
il.com> wrote:
> I try to download from this url:
> https://github.com/msysgit/msysgit/releases/download/Git-1.9.5-previe=
w20150319/Git-1.9.5-preview20150319.exe
>
> It is redirect to amazon aws with url but not responsed:
> https://s3.amazonaws.com/github-cloud/releases/325827/8ddeba82-ce92-1=
1e4-9812-db61045d243b.exe?response-content-disposition=3Dattachment%3B%=
20filename%3DGit-1.9.5-preview20150319.exe&response-content-type=3Dappl=
ication/octet-stream&AWSAccessKeyId=3DAKIAISTNZFOVBIJMK3TQ&Expires=3D14=
33671774&Signature=3DQn3RvEVrb01Gm9wPJ7s6DObwAdM%3D
>

You'll get a working download at http://git-scm.com/download/win

Also note that a preview of the imminent Git 2.x release for Windows
is available for download on http://git-for-windows.github.io/
