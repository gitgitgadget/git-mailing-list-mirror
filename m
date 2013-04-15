From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Mon, 15 Apr 2013 17:24:47 -0500
Message-ID: <CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 00:24:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URrpV-0001kG-Nl
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 00:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755510Ab3DOWYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 18:24:49 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:64435 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517Ab3DOWYt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 18:24:49 -0400
Received: by mail-la0-f41.google.com with SMTP id er20so4849274lab.14
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 15:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Cbdz7cLc4m46XCJUJpzQ6rlkwOm8tUVCKBKL+5/TEpk=;
        b=eG2EWRqpINnW/FjKz3EZIJrKRHX/zHRWTWI9KlCS1rfSzc8m2H2bWjWy3haNl5mXi/
         fQQdoupACmn/u7QwzsMw3Vg3Tc5B5kKb60ic43F2PNDi2I5bGI8QXK2vgP8msnTAgJhl
         /Kh9y8VOsBGzAXa/8wR3F5vx5EpFFVPlGdUbBUHD0Slq7qSaNhNGLbh4Wzapg77cPMf0
         6EQWuCBt0ICOa7OVIFZ/LRtMfbrPaf4SkfSBU1GNDTaM0rTHpZarM/ijYI8lEn98Ay1w
         Babs0J0iyjS1LnGaogF/2oh9VJO9yNDi7wWtT4KvZumzjQltRE7xbP9+EEeCal1U7Ao6
         f43Q==
X-Received: by 10.152.113.34 with SMTP id iv2mr11406962lab.20.1366064687439;
 Mon, 15 Apr 2013 15:24:47 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Mon, 15 Apr 2013 15:24:47 -0700 (PDT)
In-Reply-To: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221323>

On Mon, Apr 15, 2013 at 3:28 PM, Junio C Hamano <gitster@pobox.com> wrote:

> * fc/remote-hg (2013-04-11) 21 commits
>  - remote-hg: activate graphlog extension for hg_log()
>  - remote-hg: fix bad file paths
>  - remote-hg: document location of stored hg repository
>  - remote-hg: fix bad state issue
>  - remote-hg: add 'insecure' option
>  - remote-hg: add simple mail test
>  - remote-hg: add basic author tests
>  - remote-hg: show more proper errors
>  - remote-hg: force remote push
>  - remote-hg: push to the appropriate branch
>  - remote-hg: update tags globally
>  - remote-hg: update remote bookmarks
>  - remote-hg: refactor export
>  - remote-hg: split bookmark handling
>  - remote-hg: redirect buggy mercurial output
>  - remote-hg: trivial test cleanups
>  - remote-hg: make sure fake bookmarks are updated
>  - remote-hg: fix for files with spaces
>  - remote-hg: properly report errors on bookmark pushes
>  - remote-hg: add missing config variable in doc
>  - remote-hg: trivial cleanups
>
>  Rerolled.
>
>  Waiting for comments.

>From whom?


And about this:
http://mid.gmane.org/1365638832-9000-3-git-send-email-felipe.contreras@gmail.com

I think it's a disservice to git users to not consider this a "cooking
patch", specially since it's only the commit message somebody was
worried about. But whatever, don't.

Cheers.

-- 
Felipe Contreras
