From: David Michael Barr <b@rr-dav.id.au>
Subject: Re: Subtree in Git
Date: Sat, 2 Mar 2013 22:21:37 +1100
Message-ID: <CACPE+fvuKiYmmGfJ=A_DZyOi+MiQQ3SgY+QyX5L08XK8TMwzEw@mail.gmail.com>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
	<nngk410vrja.fsf@transit.us.cray.com>
	<4F9FA029.7040201@initfour.nl>
	<87fwbgbs0h.fsf@smith.obbligato.org>
	<7v8vh78dag.fsf@alter.siamese.dyndns.org>
	<4FA82799.1020400@initfour.nl>
	<nngzk9jvemb.fsf@transit.us.cray.com>
	<nngaa0z3p8b.fsf@transit.us.cray.com>
	<87bokpxqoq.fsf@smith.obbligato.org>
	<4FD89383.70003@initfour.nl>
	<nng4npe6zsj.fsf@transit.us.cray.com>
	<50830374.9090308@initfour.nl>
	<7vbofwgwso.fsf@alter.siamese.dyndns.org>
	<5084102A.2010006@initfour.nl>
	<nnga9vefu1v.fsf@transit.us.cray.com>
	<508A8BD3.9020901@initfour.nl>
	<2DDAA35052EA4F88A6EAC4FBDDF7FCCD@rr-dav.id.au>
	<loom.20130301T032627-983@post.gmane.org>
	<CALeLG_maSpjVtO3swZAWV12Cr7rDWOaJ=Jh8zw5tJn0EGGW+fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kindjal <kindjal@gmail.com>, git <git@vger.kernel.org>
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Sat Mar 02 12:22:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBkW5-0000T2-Fs
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 12:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962Ab3CBLVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Mar 2013 06:21:40 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:53553 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936Ab3CBLVj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Mar 2013 06:21:39 -0500
Received: by mail-ie0-f178.google.com with SMTP id c13so4635506ieb.9
        for <git@vger.kernel.org>; Sat, 02 Mar 2013 03:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=qGhvnSZIiGrVMFjZ332xBQWDqjjN3lxj0qA+UWC0rZ0=;
        b=asn6ArdI/xLF9fj1pMusY4nwARo64QVCYb3B/wegt1D1tf/V9jolRBK7I04c7VSzNa
         wd5pwTWWPp1nntfrJLnq9r8TfcAbnzPhMWdeo5rwVzbkk/ku7pnvB96/qw6c5AiC0Q1c
         3bwIxz05Fvrh5JBPuuwDTTSHOWMSozJuRl/0dLuzXld0x+ViL8YA2fFv+YBVOjha73Mo
         ZvEmRplafFe6FSfjPVinNeSaUP2AxSKpTn8091lxmWlmBzRlgXPfyVkOQJ4jPfnGVh1q
         zAm5IiO5IR64VVarhBHB9PQG7keJ40QzuBeVS+7/nQimQHkz9Aubje19hYunIr01Cjxi
         YfXQ==
X-Received: by 10.42.18.138 with SMTP id x10mr13107515ica.22.1362223297888;
 Sat, 02 Mar 2013 03:21:37 -0800 (PST)
Received: by 10.231.246.133 with HTTP; Sat, 2 Mar 2013 03:21:37 -0800 (PST)
X-Originating-IP: [122.107.58.35]
In-Reply-To: <CALeLG_maSpjVtO3swZAWV12Cr7rDWOaJ=Jh8zw5tJn0EGGW+fA@mail.gmail.com>
X-Gm-Message-State: ALoCoQkMNAAqSZPkeUuG+LN7Lpm5U4+2NhKctEb83BrZiItoDDstEjuYj+qyF6tkZo4MYXkUMLnN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217325>

On Sat, Mar 2, 2013 at 9:05 AM, Paul Campbell <pcampbell@kemitix.net> wrote:
> On Fri, Mar 1, 2013 at 2:28 AM, Kindjal <kindjal@gmail.com> wrote:
>> David Michael Barr <b <at> rr-dav.id.au> writes:
>>
>>> From a quick survey, it appears there are no more than 55 patches
>>> squashed into the submitted patch.
>>> As I have an interest in git-subtree for maintaining the out-of-tree
>>> version of vcs-svn/ and a desire to improve my rebase-fu, I am tempted
>>> to make some sense of the organic growth that happened on GitHub.
>>> It doesn't appear that anyone else is willing to do this, so I doubt
>>> there will be any duplication of effort.
>>>
>>
>> What is the status of the work on git-subtree described in this thread?
>> It looks like it's stalled.
>>
>
> I hadn't been aware of that patch. Reading the thread David Michael
> Barr was going to try picking the patch apart into sensible chunks.
>

Sorry for not updating the thread. I did end up moving onto other things.
I quickly realised the reason for globbing all the patches together was
that the individual patches were not well contained.
That is single patches with multiple unrelated changes and multiple
patches changing the same things in different directions.
To me this means that the first step is to curate the history.

> If this work is still needing done I'd like to volunteer.

You're most welcome. Sorry again for abandoning the thread.

--
David Michael Barr
