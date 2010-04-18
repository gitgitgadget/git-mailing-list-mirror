From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH 1/2] SubmittingPatches: Add new section about what to 
	base work on
Date: Sun, 18 Apr 2010 22:24:07 +0200
Message-ID: <j2yfabb9a1e1004181324w759d6dcbs8a68a402b3b91a78@mail.gmail.com>
References: <1271620400-sup-4850@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 22:24:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3b2m-0003cj-DE
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 22:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480Ab0DRUYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 16:24:33 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:56162 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191Ab0DRUYc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 16:24:32 -0400
Received: by bwz25 with SMTP id 25so4812627bwz.28
        for <git@vger.kernel.org>; Sun, 18 Apr 2010 13:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=LXoCaZXIqMeR2Lu902un2u0jC4QxmSLLmWr6h0OK20w=;
        b=CFUcHSqwOwGKnMx6fcntM7xUCNgxufPR0JVG+6YXuPtbM944aYZwnM66lw/Ga2RMWw
         i9XHZwiwQOqfYxPk5xWZAti5T4Gpg9uIuY3XdnDfSUBRJeQwyB0ABmrTz0Gyp8+tC4r+
         kyvJB6qVyKVOIo+bn+VUkn8mx6+pIMzhEGhwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Wz2pUGUBOswgX6rDOV3ctnLj6YPH6CKzBMFLwpq40+qSnooMqM3rMn0Y0EEzVyA4bP
         sIcR0urftLO4x1g25S08OMHY6fkxHDbFWpkBQxu2HnGFhw4PobTYhNg90Cm7vKTayld1
         3BOVJsYXUABpSKCfpqPnTCJj+J0wQkOZBPsts=
Received: by 10.103.168.14 with HTTP; Sun, 18 Apr 2010 13:24:07 -0700 (PDT)
In-Reply-To: <1271620400-sup-4850@kytes>
Received: by 10.103.3.39 with SMTP id f39mr2878172mui.83.1271622267139; Sun, 
	18 Apr 2010 13:24:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145244>

Heya,

On Sun, Apr 18, 2010 at 21:54, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> From: Junio C Hamano <gitster@pobox.com>

That's my fault, I should have been more clear in that this should
have been at the top of the message :). Either way, the idea (that
this patch was a literal re-send of Junio's patch) was conveyed
successfully I think.

-- 
Cheers,

Sverre Rabbelier
