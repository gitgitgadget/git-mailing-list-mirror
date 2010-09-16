From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2] po/de.po: add German translation
Date: Thu, 16 Sep 2010 11:09:52 +0000
Message-ID: <AANLkTikvW=YY2X9VR8oS2pk3fs9KFkQ_O7m=zOEN4nEk@mail.gmail.com>
References: <20100915093313.44396t6yr62ixccg@webmail.tu-harburg.de>
	<20100916125751.163d8691@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Stimming <stimming@tuhh.de>, trast@student.ethz.ch,
	git <git@vger.kernel.org>
To: =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Thu Sep 16 13:10:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwCLn-0006Vi-J0
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 13:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531Ab0IPLJy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 07:09:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57071 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360Ab0IPLJx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 07:09:53 -0400
Received: by iwn5 with SMTP id 5so982298iwn.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 04:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MISxmR2yFJcmhIDFNeKpm9urB6RUAB5uv9cdjni5ij8=;
        b=j2VtMm6KGZOp6q/8gGmzUp9oS/vy16tcAOObkvRtItX5emNgY0gr36wqati0nlX6Y6
         APK9yzjWGk0/hlUMhIRs5Lo8QcROKcgwKcn0TbHBnZkT5ezguUtAv7uJ0530BIF8zIJn
         7fNG+1VSyjffaClXbRuQeJUCjE+E7YGJ0Ijfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XQugEQ22SNroQ5HrQqm945L8QTlQLbCX0oR9xJTKdh6eFrYh5vZ4aJHHwKXXG12NBT
         y16Oz7Ezn8ufAhOe8ZIi+664lgGfR9UYY+JvvLO+9RwSXtJlabVvc4xXbPSiDngio1PD
         FFRWpX269jpNFosUZA+znIGJtYqW4sYsGFfRc=
Received: by 10.231.148.83 with SMTP id o19mr3353851ibv.112.1284635392894;
 Thu, 16 Sep 2010 04:09:52 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 16 Sep 2010 04:09:52 -0700 (PDT)
In-Reply-To: <20100916125751.163d8691@jk.gs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156318>

On Thu, Sep 16, 2010 at 10:57, Jan Kr=C3=BCger <jk@jk.gs> wrote:

> My main reason for not translating this one is that we have a command
> called "branch" and since people need to learn what it means anyway,
> and we're certainly not going to change the command names in differen=
t
> languages [...] "Markierung" doesn't come close at all to describing =
the same
> concept. Conflicts markers are "Markierungen"; tags are not.
> The command name reasoning applies here, too.

=46WIW we could translate the command names if we wanted to, but whethe=
r
to do that or not is something we'll have to look at in due time.
