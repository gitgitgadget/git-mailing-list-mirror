From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH] RelNotes: noted the addition of contrib/diffall
Date: Fri, 9 Mar 2012 13:41:57 -0500
Message-ID: <CAFouetg7rZ3F6iUgXbHX0kDCo0kje4yx8T0sfHseXxDnJosbAw@mail.gmail.com>
References: <7v8vjadfgg.fsf@alter.siamese.dyndns.org>
	<1331300127-21169-1-git-send-email-tim.henigan@gmail.com>
	<7v399h7i96.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 19:42:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S64lP-0006EG-2f
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 19:42:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115Ab2CISl7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Mar 2012 13:41:59 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48262 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758599Ab2CISl6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 13:41:58 -0500
Received: by yenl12 with SMTP id l12so1038402yen.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 10:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=gdSsjnSpt7av7EUeBWMEbKcj5KEwKkzK1/LuvfpyyNE=;
        b=xGoTEzCmvNOWUjBIi9GyGlxliO3ZyeITcQ2Mi1p1yGeRP+SlhNPWX6UwVnnSa6vpwN
         j/Z5PTPdyBhPM2/hYFaan8lXbyEdKMsOKREjHEAjdz8Fht4BVDJkvmnaIzhRagXURKR8
         MYztsd0GU4g0FhONormGfHeTwWtpBs2Oj1BMEs6DBlY5vKHESaHWvC6SIZ15YcgXFUb0
         tA649ziBQfPnKsXWXzlGaZGQcROommjHMcKNnsuAArvOw2O4tlbbhgh3iHToxKUsj+JP
         +S7K7vsTNZuf900tYh8xLl1AzGt8qOodG4fUpxlncOe5Urk9m/HehV0t+GdGkZaPJNtk
         uPRw==
Received: by 10.50.37.236 with SMTP id b12mr4805849igk.36.1331318517565; Fri,
 09 Mar 2012 10:41:57 -0800 (PST)
Received: by 10.42.218.65 with HTTP; Fri, 9 Mar 2012 10:41:57 -0800 (PST)
In-Reply-To: <7v399h7i96.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192734>

On Fri, Mar 9, 2012 at 1:15 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
>> + * "git diffall" can now be installed from contrib/. The script dri=
ves
>> + =C2=A0 an external tool to perform a directory diff of two Git rev=
isions.
>
> I'm tempted to add a third line, like this:
>
> =C2=A0 ... an external tool to perform a directory diff of two Git re=
visions
> =C2=A0 in one go, unlike "difftool" which compares one-file-at-a-time=
=2E
>
> to make the true value of this new addition stand out.

I like the added third line, but would remove the dashes in
"one-file-at-a-time".

Thanks,
Tim
