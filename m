From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Sat, 10 Oct 2009 20:17:10 +0800
Message-ID: <be6fef0d0910100517h1a8b9551jc890251665bbcd69@mail.gmail.com>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org>
	 <1255065768-10428-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 10 14:23:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwayT-0006tV-1L
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 14:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758652AbZJJMRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 08:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758643AbZJJMRr
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 08:17:47 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:48735 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758306AbZJJMRr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 08:17:47 -0400
Received: by iwn10 with SMTP id 10so1598417iwn.4
        for <git@vger.kernel.org>; Sat, 10 Oct 2009 05:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=fe7TlFgK1KY3Du8knA6nnNUbgAb9cFzCiYAgTrx5Hdk=;
        b=bzrfvaZnaN4rz8YcwwIVVoEUrywJsIGkNRWV02cG8sKI+8tKVTJneSSSjwX2t8Qg3h
         3LZ8s7fP00eaUUbQufdAY5xe6VvdBf90oesy9jhnW7RlxyqrnN1+xgdb2uKPpf21Qpx4
         lkI6uAHwRKI1iGxNB9XijqMAqFuxoy3JU24FA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Ors0i+cKq4ARbfSkQZf84zcLF6XwyKdz0uzEC1aH7pUu3OGCehwCP3UzhAELHjMY4d
         uQIBSmkx3Atx8NU5HaIO8o3K9VBoXPJcsHRHevniSMMj3fzxOFKlK4AMlPF0h4m5j97y
         Xd87ewd3gkVdLmTaunR4WtnazHsAfNOH22KAM=
Received: by 10.231.82.84 with SMTP id a20mr4097929ibl.34.1255177030495; Sat, 
	10 Oct 2009 05:17:10 -0700 (PDT)
In-Reply-To: <1255065768-10428-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129880>

Hi,

On Fri, Oct 9, 2009 at 1:22 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> +Smart Clients
> +~~~~~~~~~~~~~
> +
> +HTTP clients that support the "smart" protocol (or both the
> +"smart" and "dumb" protocols) MUST discover references by making
> +a paramterized request for the info/refs file of the repository.

s/paramterized/parameterized/ -- missing 'e'.

-- 
Cheers,
Ray Chuan
