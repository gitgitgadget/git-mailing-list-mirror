From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: gitk: Portuguese "Ignore space change" translation
Date: Wed, 21 Nov 2012 21:18:35 -0200
Message-ID: <CACnwZYf6E8OvAToyRQ7HkxRa3=pYjQU5x5BqNqFt0nioxtny5w@mail.gmail.com>
References: <CADJyvEdgeC1fHWz9sU6RDUcrfXbkk5qZ6RVBp5iYUcvbnh2BdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Joao Vitor P. Moraes" <jvlppm@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 21:36:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbdVw-0005xJ-BZ
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 21:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655Ab2KVUgb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2012 15:36:31 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44531 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756576Ab2KVUg3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2012 15:36:29 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so3785881lbb.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 12:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=NcIcCgFVPsMb5DM1V/pHdelva0zhcoOymSBxR+17DIc=;
        b=cPwmiFVHAMMrFPAAiLdYs4Q0WVnWqmB1X+/rxLlCYKCU5wrYLhtrOqmhfJQ3CWP7wc
         5R9HDwqJfJ5bIP8nDYWSYX5ogVk6KQJGU2oobQ/j18BPrhgYLEOP0SGA/jsuNufn0m0B
         J3o5M6eEqopNSOB0xc5jup7KdHRickSfP+HZsEfydpe54C8geUQqSGi7X/cuJcoQIl+A
         APdpQkN2y6oy8Qrf39qjwgcPatR+HFypaU5C6lhP+/XTJdXMaY+2RqxZMWeGn0j9McLy
         ONGss7NdOHL01F/gNzIAmt3Gg5nPxYXVd/HJdb3xa7JDFpIK36yF1QKZDTz5n/rGNf4e
         vdAg==
Received: by 10.152.131.200 with SMTP id oo8mr19156734lab.34.1353539915373;
 Wed, 21 Nov 2012 15:18:35 -0800 (PST)
Received: by 10.112.132.162 with HTTP; Wed, 21 Nov 2012 15:18:35 -0800 (PST)
In-Reply-To: <CADJyvEdgeC1fHWz9sU6RDUcrfXbkk5qZ6RVBp5iYUcvbnh2BdA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210211>

Hi Joao,

On Tue, Nov 20, 2012 at 8:03 AM, Joao Vitor P. Moraes <jvlppm@gmail.com=
> wrote:
> Inside gitk there's a checkbox which says:
> Ignore space change
>
> It was translated to portuguese (pt-br) as:
> Ignorar mudan=C3=A7as de caixa
>
> But that message in portuguese means:
> Ignore case changes
>
> that checkbox does not ignore case changes, but instead it ignores sp=
ace
> changes, a better translation would be
>
> Ignorar mudan=C3=A7as de espa=C3=A7o
> or
As a native speaker I'd say go with that one. Although 'Ignorar
espa=C3=A7amentos' sounds more succinct.
