From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Sun, 8 Feb 2009 11:07:30 +0100
Message-ID: <2c6b72b30902080207m4a1e14b7j4862f9a8b7ca32a9@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <20090206104946.GE7259@b2j>
	 <2c6b72b30902060629i2539ddds48ab858e83d4bb4@mail.gmail.com>
	 <slrngooljv.urh.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 11:09:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW6ax-0002GC-8O
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 11:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbZBHKHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 05:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752975AbZBHKHd
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 05:07:33 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:55291 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972AbZBHKHc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 05:07:32 -0500
Received: by bwz5 with SMTP id 5so460684bwz.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 02:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=17HRCYocJdUvwo2fgpr1CYYC31ICSgjufpPZwmtjt0A=;
        b=ovAdQeUNn82ik7aEmBiTThTJ3dIyh9Ba1VFj5sVfjlfoZCQ+kMSkqXNZtztvqK4TFe
         19qZh35lBm1nVntmHjyy4xobQ1sEi1/TG0oZb4Wm57i7LGhULRQ4/f3NkF1x9P9DNtef
         7z9kU5SXFXf1vIuwqCWCGJ28ZzIKCBmn3FzkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oCPQ48XDDEkKL6PgY3QvoUH6RKz6tjIx/KzGPjWvBIFqZIjxYGnS/rw71KY1ZXQbPO
         8Fq0dSBKVjXelCKxz/WSRKmVJ5/DtiI/UfdyKjxzQtw8f3NH7PUUZriFtxM0AN0a5HYf
         E1zeGFut2ZkepkdVKi7hsWVNuQ/497FzYBGoM=
Received: by 10.181.37.6 with SMTP id p6mr1358254bkj.29.1234087650296; Sun, 08 
	Feb 2009 02:07:30 -0800 (PST)
In-Reply-To: <slrngooljv.urh.sitaramc@sitaramc.homelinux.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108945>

On Fri, Feb 6, 2009 at 16:25, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> On 2009-02-06, Jonas Fonseca <fonseca@diku.dk> wrote:
>> Two things tig does not (yet) support is splitting and editing a hunk.
>
> But I must say that the last time I did this, the hunks that
> tig showed me were more granular than what 'git gui' did; no
> idea why.  To do what I wanted to do in 'git gui' was
> possible, by staging line by line instead of hunk by hunk,
> but I didn't fancy all that clicking and tig saved me.

Great to hear. I sometimes, miss though, being able to lower the diff
context to 1 or 2, however, maybe I should learn to commit more often
instead.

-- 
Jonas Fonseca
