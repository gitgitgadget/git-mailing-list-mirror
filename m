From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2010, #01; Fri, 02)
Date: Fri, 2 Apr 2010 10:48:39 -0600
Message-ID: <w2jfabb9a1e1004020948m159174faj3240eee211986fc2@mail.gmail.com>
References: <7vaatmckmi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 18:56:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxkAd-0001eO-Ly
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 18:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab0DBQ4b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 12:56:31 -0400
Received: from mail-gx0-f209.google.com ([209.85.217.209]:63036 "EHLO
	mail-gx0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961Ab0DBQ4a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 12:56:30 -0400
Received: by gxk1 with SMTP id 1so1750398gxk.16
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=rxix3sQDT7x3fYihqs2MhXOW8lyAZCQJqKEjCbYPvg4=;
        b=eJ6hs3Xp6/HqltHjVVm6H7NX4QV3CNhm8cjUTaJa3L2UvyE8AbTFGaH7itVVrBMqaN
         aUi6GNqHOyzxQbFng+W19DqhaAzGWB14uSkeoY4oOrY0C+BopWccm9/vf3mkhyPzEl28
         0TEPslWz7rYWpgOVOyt21MYjr8/uLtctSYEKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=G87D6YnVttUAuopGMRyKavIN2dc/OkUxayUxYZNclG+k8V/LgcCHZds8or76+xFaMT
         3yRTW8RRKIsSuJSZ7Nxfb8K8mQv9EZoTGRubPdqa2sqhlzQIBLCg6zshkk0noxizB6Ht
         Wj1I7zGtyNOqswZl3zFPhJmikQux5Gvimokeg=
Received: by 10.100.206.13 with HTTP; Fri, 2 Apr 2010 09:48:39 -0700 (PDT)
In-Reply-To: <7vaatmckmi.fsf@alter.siamese.dyndns.org>
Received: by 10.101.2.29 with SMTP id e29mr5283910ani.212.1270226939346; Fri, 
	02 Apr 2010 09:48:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143826>

Heya,

On Fri, Apr 2, 2010 at 02:40, Junio C Hamano <gitster@pobox.com> wrote:
> * sr/remote-helper-export (2010-03-29) 7 commits
> =A0- remote-helpers: add tests for testgit helper
> =A0- remote-helpers: add testgit helper
> =A0- remote-helpers: add support for an export command
> =A0- remote-helpers: allow requesing the path to the .git directory
> =A0- fast-import: always create marks_file directories
> =A0- clone: also configure url for bare clones
> =A0- clone: pass the remote name to remote_get
>
> May merge to 'next', but I would prefer waiting til 1.7.2 to have
> this with a confidence than fast-tracking it.

Agreed, if 1.7.2 will be a short cycle I don't mind waiting a few more =
weeks :).

--=20
Cheers,

Sverre Rabbelier
