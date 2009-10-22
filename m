From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] Documentation/merge-options.txt: order options in alphabetical
 groups
Date: Thu, 22 Oct 2009 11:50:09 -0700
Message-ID: <4AE0A961.7040900@gmail.com>
References: <87iqe7zspn.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Oct 22 20:50:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N12k0-0006uD-3a
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 20:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561AbZJVSuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 14:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753899AbZJVSuO
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 14:50:14 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:39899 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbZJVSuN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 14:50:13 -0400
Received: by fxm18 with SMTP id 18so9534914fxm.37
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 11:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=qOCuqxC6OIzdHFI6JwqXdL680ZnUyHH4lw+de2SJ3fM=;
        b=OlZJ9xXdPw2fMoz0UgR8/vJDFD3uNfJT20AblA9Guu2sF+lCqafryCwLzyR0WaYM7w
         7C15XWt0lT25ucKeY7M5LHKqx4jH3+Pby/5ePG6U0gcQG3bnfXwJq0YH7F1BcR2awgeX
         DPjqkz4rK8L5a7JR43jIUEkhXADuLaWSx7qJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=lIXa3n9jfk9GnbWOfFLuu9DilXxd8O+CXtKF/VWu0gf3Jxo3zZ5v1xCMPrvMiPe+ab
         MSOUMjvgwxyqNNLUjseWhlpuO1Z74sLLyEIQPS7rIn6i/xbfDWhSXgrIZjRjmPTAdFIY
         l96b2OgpfOrc2w8BmO/iL4C+SYhh+fYlOFS0A=
Received: by 10.102.216.8 with SMTP id o8mr4350850mug.20.1256237415861;
        Thu, 22 Oct 2009 11:50:15 -0700 (PDT)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id j6sm1978675mue.20.2009.10.22.11.50.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Oct 2009 11:50:14 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090827)
In-Reply-To: <87iqe7zspn.fsf@jondo.cante.net>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131039>

Jari Aalto wrote:
> +--stat::
> +-n::
> +--no-stat::
> +	Show a diffstat at the end of the merge. The diffstat is also
> +	controlled by the configuration option merge.stat.
> +
> +	With -n or --no-stat do not show a diffstat at the end of the
> +	merge.

I thought we needed a plus before new paragraphs in these situations?
