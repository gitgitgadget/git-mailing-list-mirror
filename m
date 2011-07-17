From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Google Code supports Git
Date: Sun, 17 Jul 2011 17:45:36 +0200
Message-ID: <CACBZZX40M3-N1gkiHsKHZpK2dd4DeKEBA2FcvmcHzGXMgT+ihA@mail.gmail.com>
References: <CACsJy8BMK4UqVVNnhs6riVSS-OKcFKT9=XScrAw5nK2FH_u92A@mail.gmail.com>
	<CAJo=hJtqjgvEJzSqhJBUufatCpeLgpMVN0Eqps2W8WNMaQR7Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 17 17:45:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiTXL-0007pL-Gl
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 17:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987Ab1GQPpi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jul 2011 11:45:38 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:64879 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab1GQPpi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jul 2011 11:45:38 -0400
Received: by fxd18 with SMTP id 18so5249751fxd.11
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 08:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=S8b3lMI3tesX6/CdwTBFiApEC3FxubKVK4I6VHgTEBI=;
        b=ZoGL4plnB35Y8JDFYmqgHYeMBh4nJe77I/pcFecuBZHKVRVwgIi4mXT3fs3OtMZH7B
         7tVqp06kFJfUnb/idYI6TZO4K0WFeZ+bcSXYS9csWSGw6vlEJpxfcD1rntRrmDW5WYAd
         4/RHn5Au635h+sOro7ya0S9AbBOvUoe7dG6og=
Received: by 10.223.6.77 with SMTP id 13mr8741684fay.41.1310917536782; Sun, 17
 Jul 2011 08:45:36 -0700 (PDT)
Received: by 10.223.60.204 with HTTP; Sun, 17 Jul 2011 08:45:36 -0700 (PDT)
In-Reply-To: <CAJo=hJtqjgvEJzSqhJBUufatCpeLgpMVN0Eqps2W8WNMaQR7Vw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177301>

On Sun, Jul 17, 2011 at 04:26, Shawn Pearce <spearce@spearce.org> wrote=
:

> We are trying to get the engineer responsible for making Git on Googl=
e
> Code possible to give a recorded tech talk like the one Sverre linked
> to. I don't want to steal his thunder, but I can say the Git on Googl=
e
> Code work is not based on C Git or JGit. =C2=A0:-)

I don't think you have to worry about that, looks like he already
stole his own thunder:

 http://hackerne.ws/item?id=3D2769816
 http://code.google.com/u/dborowitz@google.com/

I.e. Google Code is using Dulwich:

 http://www.samba.org/~jelmer/dulwich/
