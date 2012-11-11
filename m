From: =?ISO-8859-1?Q?Deniz_T=FCrkoglu?= <deniz@spotify.com>
Subject: Re: Reviews on mailing-list
Date: Sat, 10 Nov 2012 17:28:11 -0800
Message-ID: <CA+ZXwZO8tpGi7_njbFx6w2ZAWoySVb2Bcc+DSupLenKrNAGV_A@mail.gmail.com>
References: <CA+ZXwZOnZZyk_KWmLLLNChWb1R_Av1s5jM4PsLFWKaG8BB+uXQ@mail.gmail.com>
 <CAMP44s2AvaAs-dn_eoSFWoLHBQk5QrrV=zYTOpRi2nEywoua4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <sop@google.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 02:28:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXMLv-0001KU-SM
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 02:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202Ab2KKB2d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 20:28:33 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:42637 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab2KKB2c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 20:28:32 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so3390635wgb.1
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 17:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=ekptnOozAmDlrpZDIABFyyqPVrgO6YkIcPss5D9zdgo=;
        b=g92qKwYZayLwrxzZ4yqP+bo7PfXXux6oDiNg6Bn6gxaY1tWfK1tceskXQoQxgK4M12
         5+hO1dpmFLOCdXD/RrCd1LmpKbm9OlPBCoB/0AWXrd48fmbz/xkb7zZLQwnK+EQgyZDv
         2z6daq4nUzv+Jckow+SolteQ2zQabiEtzAEXU6zKasul87ph3lDvEAXZodR2EEgEcsU6
         eSxC7ONZhnwTeG5P/c2MXJgp7ifVAjWd5bwhtIiSCVexlaoW2jN4TGzmgXjoWAlEPCO0
         kE027WFUtH0VqPoiAIPD/ePqd2ApJNaX5tadSvv1U8H7Fq+os3qTbL54xGdO2c7RhvJx
         /oUQ==
Received: by 10.180.79.37 with SMTP id g5mr9099637wix.7.1352597311601; Sat, 10
 Nov 2012 17:28:31 -0800 (PST)
Received: by 10.194.25.195 with HTTP; Sat, 10 Nov 2012 17:28:11 -0800 (PST)
In-Reply-To: <CAMP44s2AvaAs-dn_eoSFWoLHBQk5QrrV=zYTOpRi2nEywoua4w@mail.gmail.com>
X-Gm-Message-State: ALoCoQlFcJw0aRIkEHgepMrREhxkdH/4VM8FiezH+KMHla+Ym/6mMp+6MMwIW6nRd0z6h2vcJDhZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209320>

On Sat, Nov 10, 2012 at 3:40 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sun, Nov 11, 2012 at 12:19 AM, Deniz T=FCrkoglu <deniz@spotify.com=
> wrote:
>
>> This is my first mail to the git mailing list. I have been following
>> the list for some time now and I would like to suggest moving the
>> reviews out of the mailing list, for example to a gerrit instance, I
>> believe it would improve the commits and the mailing list. I have a
>> filter on 'PATCH', but I feel I miss some of the discussion, and
>> things that I would be interested in.
>>
>> I have spoken to Shawn Pearce (gerrit project lead, google) and he
>> said he is OK with hosting the gerrit instance.
>>
>> I would like to hear your thoughts on this.
>
> Personally I think reviews on the mailing list is far superior than
> any other review methods. I've even blogged about it and all the
> reasons[1]. Gerrit is better than bugzilla, but it still requires a
> web browser, and logging in.

I disagree that the current approach is optimal. Bugzilla is a
bug-tracker and is not meant to be used for reviews. I believe in
using the right tool for the right job. An e-mail should be concise
and to the point, in this case only contain the discussion. This will
help it to reach a wider audience and be more useful when people
stumble upon it through a google search.

cheers,
-deniz
