From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Uncommitted source and header files disappeared after a git mv 
	operation
Date: Wed, 23 Jun 2010 12:31:56 +0200
Message-ID: <AANLkTilNI0lq0rUqvUIdNRpubNUNqKf3_5nX3TGauvQv@mail.gmail.com>
References: <AANLkTikeW1-Kzdyu1APSqzKGsNnny6InueWluXsKMccU@mail.gmail.com>
	<AANLkTiloMDccUDObmPXPGWI_HYVDMk57EoHxZjFUiSvi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Laszlo Papp <djszapi@archlinux.us>
X-From: git-owner@vger.kernel.org Wed Jun 23 12:32:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORNFU-0001fb-Ag
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 12:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530Ab0FWKb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 06:31:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59340 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab0FWKb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 06:31:58 -0400
Received: by fxm10 with SMTP id 10so2960518fxm.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 03:31:57 -0700 (PDT)
Received: by 10.103.69.2 with SMTP id w2mr2467034muk.18.1277289116916; Wed, 23 
	Jun 2010 03:31:56 -0700 (PDT)
Received: by 10.103.213.14 with HTTP; Wed, 23 Jun 2010 03:31:56 -0700 (PDT)
In-Reply-To: <AANLkTiloMDccUDObmPXPGWI_HYVDMk57EoHxZjFUiSvi@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149503>

On Wed, Jun 23, 2010 at 12:24 PM, Laszlo Papp <djszapi@archlinux.us> wrote:
> Hello,
>
> I have got a very big trouble, so please help me if you can :(
>
> I have done a git mv operation for a whole directory, so I have put it
> into another subfolder and all my uncommitted/unpushed source and
> header files were lost ... How can I regain them ?
>
> So I did "git mv some-directory-containing-lots-of-uncommitted-changes
> total_different_folder/some-new-name". If I remember well then I did
> commit/push for that git mv operation.
>
> git status doesn't show my changes either.

I can't reproduce it. Can you provide a test case so we can reproduce
it. Additionally you should tell us more information, like git
version, architecture.

Santi
