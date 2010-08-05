From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [GSoC update extra!] git-remote-svn: Week 13
Date: Thu, 5 Aug 2010 11:42:34 -0500
Message-ID: <AANLkTi==fm8kxoB9aPYJNqBO=O9ALq-1qTzQj9RSXYBN@mail.gmail.com>
References: <20100730190124.GA2995@kytes> <0C6B8C5E-15BA-43AD-B2F2-914F39EA6046@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: David Michael Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 18:42:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh3X0-0005vl-RX
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933203Ab0HEQm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:42:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59668 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760437Ab0HEQmz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:42:55 -0400
Received: by gyg10 with SMTP id 10so2561085gyg.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 09:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=Vj3Z750T/20Hv3nQ2hudn7sl9cog+vkaxZINnNDmI30=;
        b=rAkFJJ5H5qWt3Q+JUpz/n6mWuFHSQs/+2n+/vpxewZwf9kpJsOpQgB1+2aogIggTx5
         s4PnpHhNhMxeTtSootOuLRk9z2lWzbs8XYidQmyl16CL3RBOYV/a5vuAnWpVXPWfL+D5
         yZVdqP89oqqxCCJVgaKVuC759BJaHrwFD8qcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=dueCCE5fUNNze0/6ktJWtK/3ro+oG+9ur4bU59Xe5B9nDGIZvZ72X+f0L5cbnnjQ5z
         IL8Xa/0IoeLsYr+2b+6u7DeykJiI4oo3wL7JEqqSjnkUJ2s3BMaIjN/7S4Jny6PTraAc
         NA9fY7C1JMj+7/CEJIlTjhTppO4VaciLTS67E=
Received: by 10.150.11.12 with SMTP id 12mr12666592ybk.309.1281026574205; Thu, 
	05 Aug 2010 09:42:54 -0700 (PDT)
Received: by 10.150.93.6 with HTTP; Thu, 5 Aug 2010 09:42:34 -0700 (PDT)
In-Reply-To: <0C6B8C5E-15BA-43AD-B2F2-914F39EA6046@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152687>

Heya,

On Thu, Aug 5, 2010 at 09:43, David Michael Barr
<david.barr@cordelta.com> wrote:
> The reason being that going from git to subversion there is a
> general increase in redundant data.

I don't understand?

> On the other hand, to produce an svn dump stream we may need
> to repeat elements encountered earlier in the fast-export stream.

What do you mean with this?

-- 
Cheers,

Sverre Rabbelier
